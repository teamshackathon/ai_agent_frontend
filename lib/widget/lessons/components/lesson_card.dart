import 'package:code/data/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart' show rootBundle;

class LessonCard extends HookConsumerWidget {
  const LessonCard(
      {super.key,
      required this.lesson,
      required this.onTap,
      required this.angle});

  final Lesson lesson;
  final GestureTapCallback onTap;
  final double angle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Stack(children: [
        Transform.rotate(
            angle: angle,
            child: FittedBox(fit: BoxFit.scaleDown, child: PencilSvg())),
        SizedBox(
            width: double.infinity,
            height: 100,
            child: Container(
              margin: EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    height: 10,
                  ),
                  Text("第${lesson.count}目の授業"),
                  Text("実施日："),
                  Container(
                    height: 5,
                  ),
                  Flex(direction: Axis.horizontal, children: [
                    LessonDocumentTag(label: "授業資料"),
                    LessonDocumentTag(label: "テスト"),
                    LessonDocumentTag(label: "宿題"),
                    LessonDocumentTag(label: "補足資料"),
                  ]),
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
        padding: EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue, // 背景色
                shape: BoxShape.circle, // 円形の縁
              ),
              child: Icon(
                Icons.book,
                color: Colors.white,
                size: 13.0, // アイコンのサイズ
              ),
            ),
            SizedBox(width: 4.0), // アイコンとテキストの間にスペースを追加
            Text(
              label,
              style: TextStyle(
                color: Colors.blue, // テキストの色
              ),
            ),
          ],
        ));
  }
}

class PencilSvg extends HookWidget {
  const PencilSvg({super.key});

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
        String rawSvg = await rootBundle.loadString('assets/pencil.svg');
        rawSvg = rawSvg.replaceAll('#73ff86', '#73ff86');
        rawSvg = rawSvg.replaceAll('#fff5db', '#f5f3ed');
        svgString.value = rawSvg;
      }

      loadSvg();
      return null; // クリーンアップ関数は不要
    }, []); // 初回のみ実行

    return Center(
      child: svgString.value == null
          ? const CircularProgressIndicator()
          : SvgPicture.string(svgString.value!),
    );
  }
}
