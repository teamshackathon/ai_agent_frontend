
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ダミーモード切り替え用プロバイダー
final loadingProvider = StateProvider<bool>((ref) => false);
