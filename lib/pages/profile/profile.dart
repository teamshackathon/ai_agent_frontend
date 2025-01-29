import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            return Center(child: CircularProgressIndicator());
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
                          child: CircleAvatar(
                            radius: 40, // プロフィール画像のサイズ
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            child: Text(
                              snapshot.data!.name.substring(0, 2), // 仮のイニシャル
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
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
