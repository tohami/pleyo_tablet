import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle fontStyle;
  final EdgeInsets padding;
  final bool? isEnabled;
  final Function(String)? onDoneClick ;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.fontStyle,
    this.onDoneClick ,
    this.padding =
        const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("inside build") ;
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(ColorCode.primaryBackground),
        borderRadius: BorderRadius.circular(10.0),
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
        autofocus: false,
        keyboardType: keyboardType,
        style: fontStyle,
        enableSuggestions: false,
        onSubmitted: (query) {
          onDoneClick?.call(query);
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.textSmall.copyWith(
            fontFamily: 'CoconPro',
            color: const Color(ColorCode.grey2),
            fontWeight: FontWeight.w300,
          ),
          focusedErrorBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: padding,
        ),
        cursorColor: Colors.white,
        cursorWidth: 2.5,
        enabled: isEnabled,
        // cursorHeight: 10,
      ),
    );
  }
}
