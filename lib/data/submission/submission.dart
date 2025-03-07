import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../quiz/quiz.dart';
import '../result/result.dart';

part 'submission.freezed.dart';

@freezed
class Submission with _$Submission {
  const Submission._();

  const factory Submission({
    required String name,
    required List<Result> testResults,
    required List<Quiz> homeworks,
    required List<Result> homeworkResults,
    required DocumentReference reference,
  }) = _Submission;

  factory Submission.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data();
    final List<Result> testResults = [];
    final homeworks = [for (var m in map?["homeworks"] ?? []) Quiz.fromMap(m)];
    final List<Result> homeworkResults = [];

    // 採点結果を見る
    for (var m in map?["questions_result"] ?? []) {
      testResults.add(Result.fromMap(m, true));
    }
    // 採点結果に穴があれば採点前回答で埋める
    for (var m in map?["questions_answer"] ?? []) {
      if (testResults.where((r) => r.title == m["title"]).isEmpty) {
        testResults.add(Result.fromMap(m, false));
      }
    }

    // ↑の宿題版
    for (var m in map?["homeworks_result"] ?? []) {
      homeworkResults.add(Result.fromMap(m, true));
    }
    for (var m in map?["homeworks_answer"] ?? []) {
      if (homeworkResults.where((r) => r.title == m["title"]).isEmpty) {
        homeworkResults.add(Result.fromMap(m, false));
      }
    }

    return Submission(
      name: map?["name"] ?? "",
      testResults: testResults,
      homeworks: homeworks,
      homeworkResults: homeworkResults,
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toFirestore() {
    final tr = [for (var r in testResults) r.toMap()];
    final hw = [for (var q in homeworks) q.toMap()];
    final hwr = [for (var r in homeworkResults) r.toMap()];

    return {
      "name": name,
      "questions_result": tr,
      "homeworks": hw,
      "homeworks_result": hwr,
    };
  }

  factory Submission.isBlank() {
    return Submission(
      name: "",
      testResults: [],
      homeworks: [],
      homeworkResults: [],
      reference: FirebaseFirestore.instance.collection("2024").doc(),
    );
  }
}
