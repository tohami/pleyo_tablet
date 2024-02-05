import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';

import 'custom_text_form_field.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(ColorCode.primaryBackground),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(width: 2.0, color: const Color(0xffffffff)),
        boxShadow: const [
          BoxShadow(
            color: Color(ColorCode.shadowColor),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        autofocus: false,
        keyboardType: keyboardType,
        style: TextStyles.textSmall.copyWith(
          fontFamily: 'CoconPro',
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.textSmall.copyWith(
            fontFamily: 'CoconPro',
            color: const Color(ColorCode.grey2),
            fontWeight: FontWeight.w300,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
        ),
        cursorColor: Colors.white,
        cursorWidth: 2.5,
        cursorHeight: 27,
      ),
    );
  }
}
