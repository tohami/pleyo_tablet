import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import '../consts/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final bool obscureText;
  final String obscuringCharacter;
  final InputDecoration? decoration;
  final bool? isEnabled;

  final Widget? suffix;

  final Widget? prefix;

  final bool hasBorder;

  final String hint;

  final TextInputType keyboardType;

  final int borderColor;

  final double borderWidth;

  final Color fontColor;

  final double fontSize;

  final Function(String)? onSubmit;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.obscureText = false,
      this.decoration,
      this.obscuringCharacter = " ",
      this.isEnabled,
      this.suffix,
      this.prefix,
      this.hasBorder = false,
      this.hint = "",
      this.keyboardType = TextInputType.emailAddress,
      this.borderColor = ColorCode.blackBackground,
      this.borderWidth = 1,
      this.fontColor = const Color(ColorCode.blackBackground),
      this.fontSize = 30,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      cursorColor: const Color(ColorCode.whiteBackground),
      enabled: isEnabled ?? true,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      style: TextStyles.textLarge.copyWith(
        color: fontColor, fontWeight: FontWeight.w500, fontSize: fontSize,
        // height: 2.066666666666667,
      ),
      decoration: InputDecoration(
        enabledBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(width: borderWidth, color: Color(borderColor)),
              )
            : InputBorder.none,
        focusedBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(width: borderWidth, color: Color(borderColor)),
              )
            : InputBorder.none,
        border: InputBorder.none,
        enabled: isEnabled ?? true,
        labelStyle: TextStyles.textLarge.copyWith(
          fontSize: fontSize,
          color: fontColor,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hint,
        hintStyle: TextStyles.textMedium,
        contentPadding:
            hint.isNotEmpty ? const EdgeInsets.fromLTRB(0, 0, 0, 0) : null,
      ),
      onFieldSubmitted: onSubmit,
    );
  }
}
