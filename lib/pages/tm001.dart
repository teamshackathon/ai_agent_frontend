import 'package:code/data/room/room.dart';
import 'package:code/data/person/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firebase/auth/logout/logout_firebase.dart';
import '../widget/loading_button.dart';

class TeacherMain extends HookConsumerWidget {
  const TeacherMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(personStatusProvider);
    final rooms = ref.watch(roomsProvider);
    final displaySize = MediaQuery.of(context).size;
    final loading = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        LoadingButton(
          text: "登録",
          width: displaySize.width * 0.28,
          height: displaySize.width * 0.07,

          // 読込中はここをtrue
          isLoading: loading.value,

          // 押されたときにログアウト処理
          onPressed: () async {
            loading.value = true;
            await logoutFirebase();
            loading.value = false;
          },
        ),
        SizedBox(
          width: displaySize.width * 0.8,
          height: displaySize.width * 0.1,
          child: Text(status.toString()),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) => Card(
              child: SizedBox(
                width: displaySize.width * 0.8,
                height: displaySize.width * 0.2,
                child: Text(rooms[index].name),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
