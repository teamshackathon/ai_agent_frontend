import 'package:code/toast.dart';
import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/room/room.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class TeacherMain extends HookConsumerWidget {
  const TeacherMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRooms = ref.watch(activeRoomsProvider);

    return BasePage(
      pageTitle: "あなたの担当",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: activeRooms.when(
            data: (rooms) => TeacherMainDisplay(rooms: rooms),
            // エラー時の表示
            error: (_, __) => const Center(
              child: Text("読み込み失敗"),
            ),
            // 読込中の表示
            loading: () => const Center(
              child: SakuraProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class ClassesTabBarView extends HookConsumerWidget {
  const ClassesTabBarView({super.key, required this.rooms});

  final List<Room> rooms;

  String getClass(String room) {
    return room.split("-")[1];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return rooms.isEmpty
        ? Center(child: Text("あなたの担当しているクラスがありません"))
        : ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return InkWell(
                onTap: () {
                  ref.read(currentRoomProvider.notifier).state = room;
                  infoToast(log: room.toString());
                  GoRouter.of(context).push(Routes.teacherLessons);
                },
                child: Stack(children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      'assets/sticky_notes.svg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.school,
                              size: 40,
                              color: Colors.blue,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                "${getClass(room.roomNumber)}組",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text("授業時間：${room.dateOfLessons}"),
                        Text("教室： ${room.classrooms}"),
                        Text("生徒の人数：${room.students.length}人")
                      ],
                    ),
                  )
                ]),
              );
            },
          );
  }
}

class TeacherMainDisplay extends HookConsumerWidget {
  const TeacherMainDisplay({super.key, required this.rooms});

  final List<Room> rooms;

  List<String> subjects(List<Room> rooms) {
    final List<String> subjects = [];
    for (var room in rooms) {
      if (!subjects.contains(room.subject)) {
        subjects.add(room.subject);
      }
    }
    return subjects;
  }

  // 教科を英語から日本語に変換
  String subjectToJapanese(String subject) {
    switch (subject) {
      case "math":
        return "数学";
      case "science":
        return "理科";
      case "social":
        return "社会";
      case "english":
        return "英語";
      case "japanese":
        return "国語";
      default:
        return "その他";
    }
  }

  List<Room> roomsBySubject(
      List<Room> rooms, String subject, String gakunenNumber) {
    return rooms
        .where((room) =>
            room.subject == subject &&
            getGakunen(room.roomNumber) == gakunenNumber)
        .toList();
  }

  // 1-2のうち2を文字列として返す
  String getGakunen(String room) {
    return room.split("-")[0];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3);

    final classNumber = useState(1);
    final subjectList = subjects(rooms);
    final subject = useState(subjectList[0]);

    tabController.addListener(() {
      classNumber.value = tabController.index;
    });

    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: [
            Tab(text: "1年生"),
            Tab(text: "2年生"),
            Tab(text: "3年生"),
          ],
        ),
        Row(
          spacing: 10,
          children: subjectList.map((s) {
            return ChoiceChip(
              label: Text(subjectToJapanese(s)),
              selected: subject.value == s,
              onSelected: (selected) {
                if (selected) {
                  subject.value = s;
                }
              },
            );
          }).toList(),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subjectToJapanese(subject.value),
                style: TextStyle(fontSize: 30),
              ),
              Text("授業コマ数：30"),
              Text("一回当たりの授業数：50分")
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              ClassesTabBarView(
                  rooms: roomsBySubject(rooms, subject.value, "1")),
              ClassesTabBarView(
                  rooms: roomsBySubject(rooms, subject.value, "2")),
              ClassesTabBarView(
                  rooms: roomsBySubject(rooms, subject.value, "3")),
            ],
          ),
        ),
      ],
    );
  }
}
