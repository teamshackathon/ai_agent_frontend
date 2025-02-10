import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../data/lesson/lesson.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class TeacherTotal extends StatelessWidget {
  const TeacherTotal({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final imgPaths = lesson.summary.imgPaths;

    Future<List<Widget>> getImage(List<String> paths) async {
      final images = <Widget>[];
      for (var p in paths) {
        try {
          final String url =
              await FirebaseStorage.instance.ref(p).getDownloadURL();
          images.add(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                url,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: SakuraProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('画像の読み込みに失敗しました'));
                },
              ),
            ),
          );
        } catch (e) {
          images.add(
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text('画像の読み込みに失敗しました')),
            ),
          );
        }
      }
      return images;
    }

    return FutureBuilder<List<Widget>>(
      future: getImage(imgPaths),
      builder: (context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SakuraProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('画像の読み込みに失敗しました'));
        }

        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => data[index],
        );
      },
    );
  }
}
