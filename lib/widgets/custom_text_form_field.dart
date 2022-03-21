import 'package:flutter/material.dart';
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

  const CustomTextFormField({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      style: TextStyles.textLarge.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        // height: 2.066666666666667,
      ),
      decoration: InputDecoration(
        enabledBorder: hasBorder
            ? const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black),
              )
            : InputBorder.none,
        focusedBorder: hasBorder
            ? const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black),
              )
            : InputBorder.none,
        border: InputBorder.none,
        enabled: isEnabled ?? true,
        labelStyle: TextStyles.textLarge.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hint,
        hintStyle: TextStyles.textMedium,
        contentPadding:
            hint.isNotEmpty ? const EdgeInsets.fromLTRB(15, 0, 0, 70) : null,
      ),
    );
  }
}
