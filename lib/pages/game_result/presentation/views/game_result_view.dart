import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/game_result_controller.dart';

// ignore: must_be_immutable
class GameResultView extends GetView<GameResultController> {
  const GameResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(ColorCode.primary),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  playerPointsWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  playerNameWidget(),
                ],
              ),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'Votre score :',
                    textStyle: TextStyles.textLarge.copyWith(
                      fontFamily: 'Parisine Plus Std Clair',
                      color: const Color(ColorCode.white3Background),
                      height: 1.1666666666666667,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 420,
                    height: 210,
                    decoration: BoxDecoration(
                      color: const Color(ColorCode.darkGrayBackground),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 3.0,
                          color: controller.isChampion
                              ? const Color(ColorCode.accentLightColor)
                              : const Color(ColorCode.yellowBackground)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(ColorCode.shadowBackground),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NumberSlideAnimation(
                          number : controller.score! ,
                          duration: const Duration(seconds: 3),
                          curve: Curves.easeOut,
                          textStyle: TextStyles.textXLarge.copyWith(
                            height: 0.5833333333333334,
                            shadows: [
                              const Shadow(
                                color: Color(0x4dfeff40),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                        CustomText(
                          'points',
                          textStyle: TextStyles.textMedium.copyWith(
                            fontSize: 20,
                            height: 1.75,
                            shadows: [
                              const Shadow(
                                color: Color(0x4dfeff40),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerPointsWidget() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(ColorCode.darkGrayBackground),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              border: Border.all(
                  width: 3.0,
                  color: controller.isChampion
                      ? const Color(ColorCode.accentLightColor)
                      : const Color(ColorCode.yellowBackground)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon_coins.svg',
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 70,
                  child: CustomText(
                    controller.points ?? "",
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.textMedium.copyWith(
                      fontSize: 20,
                      shadows: [
                        const Shadow(
                          color: Color(ColorCode.textShadowBackground),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border.all(
                  width: 3.0,
                  color: controller.isChampion
                      ? const Color(ColorCode.accentLightColor)
                      : const Color(ColorCode.yellowBackground)),
              color: controller.isChampion
                  ? const Color(ColorCode.accentLightColor)
                  : const Color(ColorCode.yellowBackground),
            ),
            child: SvgPicture.asset(
              'assets/images/icon_logout.svg',
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  Widget playerNameWidget() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(ColorCode.darkGrayBackground),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              border: Border.all(
                  width: 3.0, color: const Color(ColorCode.white2Background)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/icon_person.svg',
                  fit: BoxFit.fitHeight,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 70,
                  child: CustomText(
                    controller.playerName ?? "",
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.textMedium.copyWith(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border.all(
                width: 3.0,
                color: const Color(ColorCode.grayBackground),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x42000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
              color: const Color(ColorCode.grayBackground),
            ),
            child: SvgPicture.asset(
              'assets/images/icon_add.svg',
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
