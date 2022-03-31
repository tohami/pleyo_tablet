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

import '../controllers/game_status_controller.dart';

class GameStatusView extends GetView<GameStatusController> {
  GameStatusView({Key? key}) : super(key: key);

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
                          'Quitter',
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
                    'Voulez-vous vraiment\nquitter la partie ?',
                    textStyle: TextStyles.textLarge.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  CustomText(
                    '(Vos crédits ne vous seront pas remboursés)',
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
                    'Non',
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
                    'Oui',
                    textStyle: TextStyles.textMedium.copyWith(
                        color: controller.isChampion
                            ? const Color(ColorCode.accentLightColor)
                            : const Color(ColorCode.yellowBackground),
                        fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  () {
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
