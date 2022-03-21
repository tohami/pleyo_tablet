import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';

import 'custom_text_form_field.dart';

class CustomTextFieldContainer extends StatelessWidget {
  final Widget textFieldWidget;
  final String title;

  const CustomTextFieldContainer(this.title, this.textFieldWidget, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyles.textLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 19,
          ),
          textFieldWidget,
        ],
      ),
    );
  }
}
