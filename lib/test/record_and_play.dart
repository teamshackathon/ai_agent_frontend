import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'record_and_play.freezed.dart';

@freezed
class AudioRecordState with _$AudioRecordState {
  const factory AudioRecordState({
    @Default(false) bool isRecording,
  }) = _AudioRecordState;
}

final audioRecordServiceProvider =
    StateNotifierProvider<AudioRecordService, AudioRecordState>((ref) {
  return AudioRecordService();
});

class AudioRecordService extends StateNotifier<AudioRecordState> {
  AudioRecordService() : super(const AudioRecordState());

  final _recorder = AudioRecorder();

  Future<bool> get _hasPermission async {
    return _recorder.hasPermission();
  }

  Future<void> startRecording() async {
    if (!(await _hasPermission)) {
      return;
    }
    await _checkEncoder();
    print("hoge");
    final String filePath = await getLocalFilePath();
    print("fuga");
    state = state.copyWith(isRecording: true);
    await _recorder.start(RecordConfig(encoder: AudioEncoder.pcm16bits),
        path: filePath);
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
    state = state.copyWith(isRecording: false);
  }

  Future<void> _checkEncoder() async {
    final isSupported = await _recorder.isEncoderSupported(
      AudioEncoder.pcm16bits,
    );
    if (kDebugMode) {
      print('${AudioEncoder.pcm16bits.name} supported: $isSupported');
    }
  }
}

typedef LocalFilePath = String;

// FIXME: プロダクトに入れる場合は可変にするなどの修正が必要
Future<LocalFilePath> getLocalFilePath() async {
  // 録音ファイル保存先取得
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/audio_sample.m4a';
  return filePath;
}

@freezed
class AudioPlayState with _$AudioPlayState {
  const factory AudioPlayState({
    @Default(false) bool isPlaying,
  }) = _AudioPlayState;
}

final audioPlayServiceProvider =
    StateNotifierProvider<AudioPlayService, AudioPlayState>((ref) {
  return AudioPlayService();
});

class AudioPlayService extends StateNotifier<AudioPlayState> {
  AudioPlayService() : super(const AudioPlayState()) {
    _listenPlayer();
  }

  final _player = AudioPlayer();

  Future<void> startPlaying() async {
    state = state.copyWith(isPlaying: true);
    await _setUpAudioFile();
    await _player.play();
  }

  Future<void> pausePlaying() async {
    await _player.pause();
    state = state.copyWith(isPlaying: false);
  }

  void _listenPlayer() {
    _player.playbackEventStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.completed:
          state = state.copyWith(isPlaying: false);
          break;
        default:
          break;
      }
    });
  }

  Future<void> _setUpAudioFile() async {
    final filePath = await getLocalFilePath();
    await _player.setFilePath(filePath);
  }
}
