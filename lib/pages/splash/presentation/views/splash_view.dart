import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: const Color(ColorCode.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.onStartClicked(),
              child: Container(
                width: 420,
                height: 420,
                decoration: BoxDecoration(
                  color: const Color(ColorCode.darkGrayBackground),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      width: 3.0,
                      color: const Color(ColorCode.accentDarkColor)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(ColorCode.shadowBackground),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: CustomText(
                    'START',
                    textStyle: TextStyles.textXLarge.copyWith(
                      color: const Color(ColorCode.lightGrayBackground),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomText(
              'Appuyez sur le bouton start\npour scanner votre QRcode',
              textStyle: TextStyles.textLarge.copyWith(
                fontFamily: 'Parisine Plus Std Clair',
                color: Color(ColorCode.white2Background),
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
