import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/player_name.dart';

import '../controllers/game_status_controller.dart';

class GameStatusView extends GetView<GameStatusController> {
  GameStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false) ;
        } ,
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
                    playerNameWidget(playerName: controller.playerName! , onLogoutClicked: ()=>{}),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => {showLogoutGameDialog(context)},
                      child: Container(
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
                        child: Center(
                          child: CustomText(
                            'Quit',
                            textStyle: TextStyles.textXLarge.copyWith(
                              color: controller.isChampion
                                  ? const Color(ColorCode.accentLightColor)
                                  : const Color(ColorCode.yellowBackground),
                              height: 0.5833333333333334,
                              fontFamily: 'Parisine Plus Std Clair',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLogoutGameDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                children: [
                  CustomText(
                    'Are you sure you want to\nquit the game?',
                    textStyle: TextStyles.textLarge.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  CustomText(
                    '(Your score will not be added)',
                    textStyle: TextStyles.textMedium.copyWith(
                        fontFamily: 'Parisine Plus Std Clair',
                        fontSize: 18,
                        color: const Color(ColorCode.white3Background)),
                  ),
                ],
              ),
            ),
            actions: [
              CustomButtonContainer(
                CustomButton(
                  CustomText(
                    'No',
                    textStyle: TextStyles.textMedium.copyWith(
                        color: const Color(ColorCode.black2Background),
                        fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                      () {
                    Navigator.of(context).pop();
                  },
                  backGroundColor: const Color(ColorCode.white3Background),
                  borderRadius: 4,
                ),
                width: 150,
                height: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              CustomButtonContainer(
                CustomButton(
                  CustomText(
                    'Yes',
                    textStyle: TextStyles.textMedium.copyWith(
                        color: controller.isChampion
                            ? const Color(ColorCode.accentLightColor)
                            : const Color(ColorCode.yellowBackground),
                        fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                      () {
                    controller.stopGame() ;
                    Navigator.of(context).pop();
                  },
                  backGroundColor: const Color(ColorCode.darkGrayBackground),
                  borderRadius: 4,
                ),
                width: 150,
                height: 60,
                borderWidth: 2.0,
                borderColor: controller.isChampion
                    ? ColorCode.accentLightColor
                    : ColorCode.yellowBackground,
              ),
            ],
            actionsPadding: const EdgeInsets.only(bottom: 20),
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }
}
