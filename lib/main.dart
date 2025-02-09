import 'package:sakura/toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase/firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 環境変数を読み込む
  const envFile = String.fromEnvironment('env');

  // 環境変数を読み込む
  await dotenv.load(fileName: envFile);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ローカル環境の場合はエミュレータを使用する
  if (dotenv.env['ENV'] == 'development') {
    final authHost = dotenv.env['FIREBASE_AUTH_EMULATOR_HOST'];
    final authPort = dotenv.env['FIREBASE_AUTH_EMULATOR_PORT'];
    if (authHost != null && authPort != null) {
      // Firebase Authのエミュレータを使用する
      await FirebaseAuth.instance
          .useAuthEmulator(authHost, int.parse(authPort));
    }

    final firestoreHost = dotenv.env['FIREBASE_FIRESTORE_EMULATOR_HOST'];
    final firestorePort = dotenv.env['FIREBASE_FIRESTORE_EMULATOR_PORT'];
    if (firestoreHost != null && firestorePort != null) {
      // Firestoreのエミュレータを使用する
      FirebaseFirestore.instance
          .useFirestoreEmulator(firestoreHost, int.parse(firestorePort));
    }

    final firestorageHost = dotenv.env['FIREBASE_STORAGE_EMULATOR_HOST'];
    final firestoragePort = dotenv.env['FIREBASE_STORAGE_EMULATOR_PORT'];
    if (firestorageHost != null && firestoragePort != null) {
      // storageのエミュレータを使用する
      FirebaseStorage.instance
          .useStorageEmulator(firestorageHost, int.parse(firestoragePort));
      infoToast(log: "エミュレータ起動");
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}
