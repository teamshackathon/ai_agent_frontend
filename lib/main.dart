import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase/firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 環境変数を読み込む
  const envFile = String.fromEnvironment('env');

  // 環境変数を読み込む
  await dotenv.load(fileName: envFile);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ローカル環境でFirebase Auth Emulatorを使う
  if (dotenv.env['ENV'] == 'development') {
    final host = dotenv.env['FIREBASE_AUTH_EMULATOR_HOST'];
    final port = dotenv.env['FIREBASE_AUTH_EMULATOR_PORT'];
    if (host != null && port != null) {
      await FirebaseAuth.instance.useAuthEmulator(host, int.parse(port));
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}
