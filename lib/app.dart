import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase/auth/login/get_status_from_user.dart';
import 'route/route.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      getStatusFromUser(
        ref: ref,
        user: FirebaseAuth.instance.currentUser,
      );
      return;
    }, []);

    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'clAssIstant',
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
