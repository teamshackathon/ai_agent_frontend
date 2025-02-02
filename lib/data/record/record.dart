import 'dart:async';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';

part 'record.freezed.dart';

final recordProvider =
    StateNotifierProvider<RecordService, RecordState>((ref) => RecordService());

@freezed
class RecordState with _$RecordState {
  const factory RecordState({
    @Default(false) bool isRecording,
  }) = _RecordState;
}

class RecordService extends StateNotifier<RecordState> {
  RecordService() : super(const RecordState());

  final _recorder = AudioRecorder();
  final List<Uint8List> audioChunks = [];
  Uint8List currentChunk = Uint8List(0);
  late StreamSubscription<Uint8List>? subscription;

  Future<bool> get _hasPermission async {
    return _recorder.hasPermission();
  }

  void addChunkToList(Uint8List chunk) {
    audioChunks.add(chunk);
    currentChunk = chunk;
  }

  Future<void> startRecording() async {
    if (!(await _hasPermission)) {
      return;
    }
    final stream = await _recorder
        .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    subscription = stream.listen(addChunkToList);
    state = state.copyWith(isRecording: true);
  }

  Future<void> stopRecording() async {
    subscription!.cancel();

    // chunks確認用
    for (var audio in audioChunks) {
      for (var i = 0; i < 10; i += 1) {
        final bytes = [];
        for (var j = 0; j < 10; j += 1) {
          bytes.add(
            '0x${audio[0 + i * 10 + j].toRadixString(16).padLeft(2, '0')}',
          );
        }
        print(bytes.join(' '));
      }
    }

    _recorder.stop();
    state = state.copyWith(isRecording: false);
  }
}
