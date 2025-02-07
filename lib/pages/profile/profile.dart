import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widget/base_page/base_page.dart';
import '../../data/person/person.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(personStatusProvider.future);

    return BasePage(
      pageTitle: "マイページ",
      body: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SakuraProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("読み込みエラー"));
          } else {
            return Column(
              children: [
                // 背景の装飾
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: UserIcon(
                            iconPath: snapshot.data!.iconPath,
                            name: snapshot.data!.name,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snapshot.data!.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                // 編集ボタンの処理
                              },
                              icon: Icon(Icons.edit, size: 20),
                              label: Text("プロフィール編集"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class UserIcon extends HookConsumerWidget {
  const UserIcon({
    super.key,
    required this.iconPath,
    required this.name,
    this.radius = 40,
  });

  final String iconPath;
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = FirebaseStorage.instance;
    final pdf = storage.ref(iconPath).getDownloadURL();

    final userIconPathState = useState<String>("");

    return FutureBuilder(
      future: pdf,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return CircleAvatar(
            radius: radius, // プロフィール画像のサイズ
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            child: Text(
              name, // 仮のイニシャル
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          );
        } else {
          final userIconPath = snapshot.data ?? "";
          userIconPathState.value = userIconPath;
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(userIconPath),
          );
        }
      },
    );
  }
}
