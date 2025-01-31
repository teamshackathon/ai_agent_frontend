import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
class Score with _$Score {
  const Score._();
  const factory Score({
    @Default(-1) int totalScore,
    @Default(-1) int maxScore,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

@Riverpod(keepAlive: true)
class ScoreNotifer extends _$ScoreNotifer {
  @override
  Score build() => Score();

  void rebuild() => state = Score();

  fromJson(Map<String, dynamic> json) {
    state = Score.fromJson(json);
  }
}
