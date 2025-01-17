import 'package:code/data/room/room.dart';
import 'package:code/data/person/person.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentMain extends ConsumerWidget {
  const StudentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(personStatusProvider);
    final rooms = ref.watch(roomsProvider);
    final displaySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
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
