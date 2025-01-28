import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MenuOptions {
  japanese,
  english,
  social,
  science,
  math,
}

String getSakuraSvgPath(MenuOptions option) {
  switch (option) {
    case MenuOptions.japanese:
      return 'assets/sakura_japanese.svg';
    case MenuOptions.english:
      return 'assets/sakura_english.svg';
    case MenuOptions.social:
      return 'assets/sakura_social.svg';
    case MenuOptions.science:
      return 'assets/sakura_science.svg';
    case MenuOptions.math:
      return 'assets/sakura_math.svg';
  }
}

class RadialSakuraMenuItem extends StatelessWidget {
  const RadialSakuraMenuItem({
    required Key key,
    required this.value,
    required this.angle,
    this.width = 150.0,
    this.height = 150.0,
  }) : super(key: key);

  final MenuOptions value;
  final double angle;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: angle,
        child: SvgPicture.asset(
          getSakuraSvgPath(value),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
