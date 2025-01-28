import 'package:code/firebase/firestore/get_data/get_lessons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'dart:math' as math;

import '../../../firebase/firestore/get_data/get_rooms.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import '../../../data/person/person.dart';
import '../../../firebase/firestore/get_data/get_teachers.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/sakura_redial_menu/radial_menu.dart';

class StudentMain extends HookConsumerWidget {
  StudentMain({super.key});

  final GlobalKey<RadialSakuraMenuState> _menuKey =
      GlobalKey<RadialSakuraMenuState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomsProvider);
    final user = ref.watch(personStatusProvider);

    final items = useState<List<RadialSakuraMenuItem>>([]);

    if (rooms.isNotEmpty) {
      Logger().i("rooms $rooms");
      Logger().i("_menuKey ${_menuKey}");
      _menuKey.currentState?.openMenu();
    }

    useEffect(() {
      Future(() {
        getTeachers(ref: ref);
        getRooms(ref: ref);
      });
    }, [user]);

    useEffect(() {
      if (rooms.isNotEmpty) {
        // ここでroomsを使ってRadialSakuraMenuItemを作成する。
        final newItems = <RadialSakuraMenuItem>[];
        for (int i = 0; i < rooms.length; i++) {
          {
            Room room = rooms[i];
            newItems.add(
              RadialSakuraMenuItem(
                key: UniqueKey(),
                value: getOptionFromIndex(room.id),
                angle: 2 * math.pi / rooms.length * i,
                onPressed: () async {
                  getLessons(
                    ref: ref,
                    year: room.year,
                    room: room.roomNumber,
                    subject: room.id,
                  );
                  GoRouter.of(context).push(Routes.studentLessons);
                },
              ),
            );
          }
        }
        items.value = newItems;
        _menuKey.currentState?.openMenu();
      }
    }, [rooms]);

    return BasePage(
      pageTitle: "あなたの教室",
      body: Column(children: [
        SizedBox(
            height: 600.0,
            child: RadialSakuraMenu(
              key: _menuKey,
              items: items.value,
              radius: 100.0,
              onSelected: (dynamic value) => print(value),
            )),
        if (rooms.isEmpty)
          Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ]),
    );
  }
}
