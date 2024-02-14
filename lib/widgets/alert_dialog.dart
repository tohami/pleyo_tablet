import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class AlertDialogWidget extends StatelessWidget {
  final String content;
  final String actionCancelText;
  final String actionAcceptText;
  final Function() onCancelClicked;
  final Function() onAcceptClicked;

  const AlertDialogWidget({
    Key? key,
    required this.content,
    required this.actionCancelText,
    required this.actionAcceptText,
    required this.onCancelClicked,
    required this.onAcceptClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: AlertDialog(
        content: CustomText(
          content,
          textAlign: TextAlign.start,
          textStyle: TextStyles.textMedium.copyWith(
            fontFamily: 'Helvetica Neue',
            color: const Color(ColorCode.grey4),
            fontWeight: FontWeight.normal,
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
        backgroundColor: const Color(ColorCode.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45.0),
          side: const BorderSide(
              color: Color(ColorCode.primaryBackground), width: 6),
        ),
        actions: <Widget>[
          Row(
            children: [
              TextButton(
                child: Container(
                  width: 135,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        Color(ColorCode.primaryBackground),
                        Color(ColorCode.black)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(56.0),
                    border: Border.all(
                        width: 1.0, color: const Color(ColorCode.pink6)),
                  ),
                  child: CustomText(
                    actionCancelText,
                    textStyle: TextStyles.textXSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(ColorCode.pink6)),
                  ),
                ),
                onPressed: onCancelClicked,
              ),
              Expanded(child: Container()),
              TextButton(
                child: Container(
                  width: 135,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(ColorCode.black5),
                    borderRadius: BorderRadius.circular(56.0),
                    border: Border.all(
                        width: 1.0, color: const Color(ColorCode.aqua)),
                  ),
                  child: CustomText(
                    actionAcceptText,
                    textStyle: TextStyles.textXSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(ColorCode.aqua)),
                  ),
                ),
                onPressed: onAcceptClicked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
