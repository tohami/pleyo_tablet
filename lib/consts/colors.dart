import 'package:flutter/material.dart';

class ColorCode {
  static const primaryBackground = 0xff0D1117;
  static const darkGrey = 0xff797979;
  static const lightGrey = 0xffb9b9b9;
  static const extraLightGrey = 0xffd1d1d1;
  static const yellow = 0x83d9a700;
  static const darkYellow = 0xffedb72a;
  static const lightBlue = 0x831ad4eb;
  static const darkBlue = 0xff21bae9;
  static const lightGreen = 0xff22e36d;
  static const darkGreen = 0x831fdd6c;
  static const lightPink = 0xffc849ab;
  static const darkPink = 0x83c650b6;
  static const white = 0xccffffff;

/////////////////////////////////
  static const primary = 0xff343434;
  static const accentDarkColor = 0x1a2ff7f7;
  static const accentLightColor = 0xff2ff7f7;
  static const darkGrayBackground = 0xff494949;
  static const shadowBackground = 0x42000000;
  static const textShadowBackground = 0x4d2ff7f7;
  static const lightGrayBackground = 0x4dffffff;
  static const whiteBackground = 0xffffffff;
  static const white2Background = 0x99ffffff;
  static const white3Background = 0xccffffff;
  static const white4Background = 0xe6ffffff;
  static const grayBackground = 0xffb6b6b6;
  static const yellowBackground = 0xfffeff40;
  static const darkYellowBackground = 0xffb2b22d;
  static const customAccentBackground = 0xff21adad;
  static const customAccent2Background = 0xff6efafa;
  static const blackBackground = 0x99000000;
  static const black2Background = 0xff000000;
  static const greenBackground = 0xff71f231;
  static const yellow2Background = 0xffebdc0d;
  static const yellow3Background = 0xfffeff66;
  static const redBackground = Colors.deepOrange;

  static const customGrayBackground = 0xffbfbfbf;
  static const lightBlackBackground = 0xff404040;
}

extension ColorExtension on String {
  Color? toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}