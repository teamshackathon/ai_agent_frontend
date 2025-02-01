import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SakuraProgressIndicator extends StatelessWidget {
  const SakuraProgressIndicator({
    super.key,
    this.width = 100,
    this.height = 100,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/sakura_loading.json',
      width: width,
      height: height,
      repeat: true,
    );
  }
}
