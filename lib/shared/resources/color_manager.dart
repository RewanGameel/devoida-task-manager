import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorManager {
  static const Color primary = Color(0xffFE5832);
  static const Color darkPrimary = Color(0xffCF593E);
  static const Color lightPrimary = const Color(0xffFFAA97);
  static const Color contrastLight = Color(0xffDAEDEB);
  static const Color background = Color(0xffF5F6FA);
  static const Color backgroundDark = Color(0xff040404);
  static const Color greyLightHover = Color(0xffEFF1F3);
  static const Color greySold = Color(0xffDEE2E7);
  static const Color greenLight = Color(0xffE6FAEE);

  //this change opcity with 80% look this link https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
  static Color darkGrey = const Color(0xffdddbdd);

  static const Color grey = Color(0xff737477);
  static const Color lightGrey = Color(0xffd6d6d6);
  static const Color coolGray = Color(0xff93A3B0);
  static const Color gray80 = Color.fromRGBO(147, 163, 176, 0.8);
  static const Color gray16 = Color.fromRGBO(147, 163, 176, 0.16);

  //Basic Status Colors
  static const Color missing = Color(0xffFFC559);
  static const Color info = Color(0xff006FDE);
  static const Color success = Color(0xff43B585);
  static const Color danger = Color(0xffFF0000);
  static const Color error = Color(0xffA33030);
  static const Color white = Color(0xffFFFFFF);
  static Color dimWhite = const Color(0xffF5F6FA);
  static const Color black = const Color(0xff000000);

  //App Bar titles and screen main titles
  static const Color textHeaderColor = Color(0xff1E1E1E);
  static const Color textHeaderLightColor = Color(0xffFFFFFF);

  //Regular text color
  static const Color textColor = Color(0xffFFFFFF);
  static const Color textSubTitleColor = Color(0xffa3a3a3);
  static const Color neutralGray900 = Color(0xff3A3A38);
  static const Color neutralGray700 = Color(0xff63625F);
  static const Color neutralGray100 = Color(0xffDBDBD9);

  //temp gradient color
  static LinearGradient cardGradient1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      ColorManager.darkPrimary,
      ColorManager.primary,
      ColorManager.primary,
    ],
  );
}
