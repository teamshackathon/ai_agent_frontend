import 'package:flutter/material.dart';

class ResultAndCorrect extends StatelessWidget {
  const ResultAndCorrect({
    super.key,
    required this.correctAnswer,
    required this.result,
    required this.score,
  });
  final String correctAnswer;
  final bool result;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(correctAnswer),
        ShowResult(result: result, score: score),
      ],
    );
  }
}

class ShowResult extends StatelessWidget {
  const ShowResult({
    super.key,
    required this.result,
    required this.score,
  });
  final bool result;
  final int score;
  @override
  Widget build(BuildContext context) {
    if (result) {
      return Row(
        children: [
          Text(boolToResult(result)),
          Text("${score.toString()}点"),
        ],
      );
    } else {
      return Row(
        children: [
          Text(boolToResult(result)),
          Text("0点"),
        ],
      );
    }
  }

  String boolToResult(bool result) {
    if (result) {
      return "正解";
    } else {
      return "不正解";
    }
  }
}
