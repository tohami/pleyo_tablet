import 'package:flutter/material.dart';

class ColorCode {
  static const primaryBackground = 0xff0D1117;
  static const grey = 0xff707070;
  static const grey2 = 0x80ffffff;
  static const grey3 = 0xb4c5cfd0;
  static const grey4 = 0xbeffffff;
  static const grey5 = 0xa8c5cfd0;
  static const darkGrey = 0xff797979;
  static const lightGrey = 0xffb9b9b9;
  static const lightGrey2 = 0x7fc5cfd0;
  static const lightGrey3 = 0xbac5cfd0;
  static const lightGrey4 = 0xffc5cfd0;
  static const lightGrey5 = 0xa9ffffff;
  static const lightGrey6 = 0xccc5cfd0;
  static const lightGrey7 = 0x66b9b9b9;
  static const lightGrey8 = 0x4dc5cfd0;
  static const lightGrey9 = 0xffd0d0d0;
  static const lightGrey10 =0xffd0d0d0;
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
  static const white2 = 0xa8ffffff;
  static const white3 = 0x40ffffff;
  static const white4 = 0xeeffffff;
  static const white5 = 0xfff8f8f8;
  static const black = 0xff20262d;
  static const black2 = 0x00808080;
  static const black3 = 0xff293038;
  static const black4 = 0xa7000000;
  static const black5 = 0xff12161d;
  static const shadowColor = 0x99000000;
  static const shadowColor2 = 0x00545454;
  static const shadowColor3 = 0x02000000;
  static const aqua = 0xff2ff7f7;
  static const aqua2 = 0xff8ce9fc;
  static const aqua3 = 0x4d2cbae2;
  static const aqua4 = 0x4d7bdcf4;
  static const pink = 0xffe8a9b9;
  static const pink2 = 0x4dda698b;
  static const pink3 = 0x4dfeebf1;
  static const pink4 = 0xeeE8A9B9;
  static const pink5 = 0xfeea4e84;
  static const pink6 = 0xffff009a;
  static const yellow2 = 0x4dfac339;
  static const yellow3 = 0x4dfdefb1;
  static const yellow4 = 0xfffefbce;
  static const yellow5 = 0xeefefbce;
  static const red = 0x4dca2b18;
  static const red2 = 0x4ddc978a;
  static const red3 = 0xffeda69a;
  static const red4 = 0xeefdd4cd;
  static const green = 0xeeefff76;
  static const green2 = 0xffacb94b;
  static const green3 = 0x4d5c9a7c;
  static const green4 = 0x4dc5e87a;
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