import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_button.dart';
import 'custom_button_container.dart';
import 'custom_text.dart';

Future<void> showAlert(String title, String message,
    {String? mainActionTitle,
    Function? onMainActionClicked,
    String? secondActionTitle,
    Function? onSecondActionClick}) async {
  return Get.dialog(AlertDialog(
    backgroundColor: const Color(ColorCode.primary),
    content: Container(
      width: 370,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
            title,
            textStyle: TextStyles.textLarge.copyWith(
              fontSize: 24,
            ),
          ),
          CustomText(
            message,
            textStyle: TextStyles.textXLarge.copyWith(
                fontFamily: 'Parisine Plus Std Clair',
                fontSize: 24,
                color: const Color(ColorCode.white3Background)),
          ),
        ],
      ),
    ),
    actions: [
      CustomButtonContainer(
        CustomButton(
          CustomText(
            mainActionTitle ?? 'Ok',
            textStyle: TextStyles.textMedium.copyWith(
                color: const Color(ColorCode.black2Background), fontSize: 25),
            textAlign: TextAlign.center,
          ),
          () {
            if (onMainActionClicked != null) {
              onMainActionClicked();
            }
            Get.rootDelegate.popRoute();
          },
          backGroundColor: const Color(ColorCode.white3Background),
          borderRadius: 4,
        ),
        width: 150,
        height: 60,
      ),
      secondActionTitle != null
          ? const SizedBox(
              width: 15,
            )
          : Container(),
      secondActionTitle != null
          ? CustomButtonContainer(
              CustomButton(
                CustomText(
                  secondActionTitle,
                  textStyle: TextStyles.textMedium.copyWith(
                      color: const Color(ColorCode.accentLightColor),
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                () {
                  if (onSecondActionClick != null) {
                    onSecondActionClick();
                  }
                  Get.rootDelegate.popHistory();
                },
                backGroundColor: const Color(ColorCode.darkGrayBackground),
                borderRadius: 4,
              ),
              width: 150,
              height: 60,
              borderWidth: 2.0,
              borderColor: ColorCode.accentLightColor)
          : Container(),
    ],
    actionsPadding: const EdgeInsets.only(bottom: 20),
    actionsAlignment: MainAxisAlignment.center,
  ));
}
