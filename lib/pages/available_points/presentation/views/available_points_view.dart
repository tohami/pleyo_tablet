import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/available_points_controller.dart';

class AvailablePointsView extends GetView<AvailablePointsController> {
  const AvailablePointsView({Key? key}) : super(key: key);

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
            Container(
              width: 420,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(ColorCode.darkGrayBackground),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    width: 3.0, color: const Color(ColorCode.accentLightColor)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(ColorCode.shadowBackground),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Countup(
                    begin: 0,
                    end: 200,
                    duration: Duration(seconds: 3),
                    separator: '',
                    curve: Curves.easeOut,
                    style: TextStyles.textXLarge.copyWith(
                      color: const Color(ColorCode.whiteBackground),
                      shadows: [
                        const Shadow(
                          color: Color(ColorCode.textShadowBackground),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),

                  // CustomText(
                  //   '0 0 0',
                  //   textStyle: TextStyles.textXLarge.copyWith(
                  //     color: const Color(ColorCode.whiteBackground),
                  //     shadows: [
                  //       const Shadow(
                  //         color: Color(ColorCode.textShadowBackground),
                  //         offset: Offset(0, 3),
                  //         blurRadius: 10,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    width: 12.5,
                  ),
                  SvgPicture.asset(
                    'assets/images/icon_coins.svg',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomText(
              'points disponibles pour jouer\naux jeux Pleyo !',
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
