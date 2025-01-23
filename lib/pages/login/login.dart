import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
// sleepを使うために必要
import 'dart:io';

import '../../firebase/auth/login/login_firebase.dart';
import '../../firebase/firestore/get_subject.dart';
import '../../widget/loading_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySize = MediaQuery.of(context).size;
    final id = useState<String>("");
    final pass = useState<String>("");
    final registerLoad = useState<bool>(false);
    final loginLoad = useState<bool>(false);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final animation = useMemoized(
      () => Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      ),
    );

    useEffect(() {
      if (loginLoad.value) {
        animationController.forward(); // アニメーションを開始
      } else {
        animationController.reverse(); // アニメーションを逆方向に戻す
      }
      return null;
    }, [loginLoad.value]);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF87CEFA), // 明るい空色
                  Color(0xFFB0E0E6), // 淡い青
                  Color(0xFFFFFFFF), // 白色（雲をイメージ）
                ],
                begin: Alignment.topCenter, // 上部から開始
                end: Alignment.bottomCenter, // 下部に向かう
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Manabiya AI",
                      style: GoogleFonts.sawarabiGothic(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    // SvgPicture.asset('assets/sakura.svg'),
                    Lottie.asset('assets/sakura.json'),
                    SizedBox(height: 20),
                    SizedBox(
                      width: displaySize.width * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'メールアドレス',
                          labelStyle: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 14,
                          ),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.pinkAccent),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.pinkAccent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        onChanged: (str) {
                          id.value = str;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: displaySize.width * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'パスワード',
                          labelStyle: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 14,
                          ),
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.pinkAccent),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.pinkAccent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                        ),
                        obscureText: true,
                        onChanged: (str) {
                          pass.value = str;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    LoadingButton(
                      text: "ログイン",
                      width: displaySize.width * 0.28,
                      height: displaySize.width * 0.07,
                      isLoading: loginLoad.value,
                      enabled: !registerLoad.value,
                      onPressed: () async {
                        loginLoad.value = true;
                        await loginFirebase(
                            email: id.value, pass: pass.value, ref: ref);
                        getSubjects(ref: ref);
                        loginLoad.value = false;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (loginLoad.value)
            SlideTransition(
              position: animation,
              child: Container(
                color: Colors.white.withOpacity(0.5), // 半透明の背景
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/login-loading.json',
                          repeat: true, animate: true),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
