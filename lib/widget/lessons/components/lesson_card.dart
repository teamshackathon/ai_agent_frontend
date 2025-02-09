import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../data/lesson/lesson.dart';
import '../../utils/sakura_progress_indicator.dart';

class LessonCard extends HookConsumerWidget {
  const LessonCard(
      {super.key,
      required this.lesson,
      required this.onTap,
      required this.angle,
      required this.subject});

  final Lesson lesson;
  final GestureTapCallback onTap;
  final double angle;
  final String subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Stack(children: [
        Transform.rotate(
            angle: angle,
            child: FittedBox(
                fit: BoxFit.scaleDown, child: PencilSvg(subject: subject))),
        SizedBox(
            width: double.infinity,
            height: 100,
            child: Container(
              margin: EdgeInsets.only(left: 45, right: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("第${lesson.count}回目の授業"),
                      ),
                      Container(
                        width: 10,
                      ),
                      LessonTag(state: lesson.state),
                    ],
                  ),
                  Container(
                    height: 1,
                  ),
                  Text(
                    lesson.agendaPublish.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}

class LessonDocumentTag extends HookConsumerWidget {
  const LessonDocumentTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(right: 0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue), // 枠線
                borderRadius: BorderRadius.circular(5), // 角丸
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.blue, // テキストの色
                ),
              ),
            ),
          ],
        ));
  }
}

class PencilSvg extends HookWidget {
  const PencilSvg({super.key, required this.subject});

  final String subject;

  // ランダムで0~7の数字を生成する関数
  int randomInt() {
    return (DateTime.now().millisecondsSinceEpoch % 8);
  }

  @override
  Widget build(BuildContext context) {
    final svgString = useState<String?>(null);

    // ポールスミスの色をリストとして定義
    // final List<String> paulSmithColors = [
    //   '#D8262F', // レッド
    //   '#F5A623', // オレンジ
    //   '#F8E71C', // イエロー
    //   '#73ff86', // ライトグリーン
    //   '#50B5E0', // ブルー
    //   '#4A90E2', // ディープブルー
    //   '#A07D59', // ブラウン
    //   '#F5F3ED', // オフホワイト
    // ];

    useEffect(() {
      Future<void> loadSvg() async {
        String rawSvg =
            await rootBundle.loadString('assets/pencil_$subject.svg');
        svgString.value = rawSvg;
      }

      loadSvg();
      return null; // クリーンアップ関数は不要
    }, []); // 初回のみ実行

    return Center(
      child: svgString.value == null
          ? const SakuraProgressIndicator()
          : SvgPicture.string(svgString.value!),
    );
  }
}

class LessonTag extends HookConsumerWidget {
  const LessonTag({super.key, required this.state});

  final String state;

  Map<String, dynamic> getState(String state) {
    switch (state) {
      case "before":
        return {
          "label": "授業前",
          "color": Colors.red,
        };
      case "lesson":
        return {
          "label": "授業中",
          "color": Colors.redAccent,
        };
      case "break":
        return {
          "label": "休憩中",
          "color": Colors.blue,
        };
      case "test":
        return {
          "label": "テスト中",
          "color": Colors.green,
        };
      case "after":
        return {
          "label": "授業後",
          "color": Colors.grey,
        };
      default:
        return {
          "label": "不明",
          "color": Colors.grey,
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = getState(state);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: status["color"] ?? Colors.grey), // 枠線
        borderRadius: BorderRadius.circular(5), // 角丸
      ),
      child: Text(
        status["label"] ?? "不明",
        style: TextStyle(
          fontSize: 12, // フォントサイズ
          color: status["color"] ?? Colors.grey, // テキストの色
        ),
      ),
    );
  }
}
