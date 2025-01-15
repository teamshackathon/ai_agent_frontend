import "dart:convert" as convert;

import 'package:code/data/room/room.dart';
import 'package:code/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../dummy.dart';
import '../data/user/user.dart';
import '../route/route.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = useState<String>("");
    final pass = useState<String>("");
    final displaySize = MediaQuery.of(context).size;
    final statusNot = ref.read(userStatusProvider.notifier);
    final load = useState<bool>(false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: <Widget>[
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'ID(1:教師用,2:生徒用)'),
                onChanged: (str) {
                  id.value = str; //仮置き
                },
              ),
            ),
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (str) {
                  pass.value = str; //仮置き
                },
              ),
            ),
            LoadingButton(
              text: "テスト",
              width: displaySize.width * 0.28,
              height: displaySize.width * 0.07,
              isLoading: load.value,
              onPressed: () async {
                load.value = true;
                var json = searchDummyList(id.value, "id", dummyUserList);
                if (json != "{}") {
                  var user = User.fromJson(convert.jsonDecode(json));
                  if (user.id == "1") {
                    statusNot.write(user);
                    var roomsJson =
                        fetchDummyList(user.roomIdList, "id", dummyRoomList);
                    mapListToRooms(ref, convert.jsonDecode(roomsJson)["data"]);
                    context.push(Routes.teacherMain);
                  } else if (user.id == "2") {
                    statusNot.write(user);
                    var roomsJson =
                        fetchDummyList(user.roomIdList, "id", dummyRoomList);
                    mapListToRooms(ref, convert.jsonDecode(roomsJson)["data"]);
                    context.push(Routes.studentMain);
                  }
                }
                load.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
