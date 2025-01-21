import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ダミーモード切り替え用プロバイダー
final dummyModeProvider = StateProvider<bool>((ref) => false);
