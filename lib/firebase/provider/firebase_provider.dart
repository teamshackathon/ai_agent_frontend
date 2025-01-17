import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// firebaseAuthのインスタンス（実体）監視用プロバイダー
///
/// FirebaseAuthはシングルトン
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// ログイン状態監視用プロバイダー
final authStateProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(authProvider);
  return firebaseAuth.authStateChanges();
});
