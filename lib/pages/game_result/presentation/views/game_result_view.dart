import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/player_name.dart';

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
                  const SizedBox(
                    height: 15,
                  ),
                  playerNameWidget(playerName: controller.playerName! , onLogoutClicked: ()=>{} ),
                ],
              ),
              Expanded(child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'Your score :',
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
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeOut,
                          textStyle: TextStyles.textXLarge.copyWith(
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

}
