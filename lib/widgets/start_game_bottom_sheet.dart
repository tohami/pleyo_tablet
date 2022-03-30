import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_widget.dart';
import 'package:pleyo_tablet_app/widgets/player_widget.dart';

class StartGameBottomSheet extends StatelessWidget {
  HomeController controller;
  RxBool playerIsSelected = false.obs;

  StartGameBottomSheet({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue(
        (state) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 56, vertical: 66),
              // height: playerIsSelected.value ? 500 : 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'Choix du joueur',
                    textStyle: TextStyles.textMedium.copyWith(
                      fontFamily: 'Parisine Plus Std Clair',
                      fontSize: 20,
                      color: const Color(ColorCode.white3Background),
                      height: 0.6,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomText(
                    'Qui joue ?',
                    textStyle: TextStyles.textLarge.copyWith(
                      fontSize: 40,
                      height: 0.3,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        PlayerWidget(
                          addPlayer: true,
                          onTap: () {
                            showAddPlayerDialog(context);
                          },
                        ),
                        PlayerWidget(
                          playerName: 'Kévin',
                          onTap: () {
                            playerIsSelected.value = true;
                          },
                        ),
                        PlayerWidget(
                          playerName: 'Michel',
                          onTap: () {
                            playerIsSelected.value = true;
                          },
                        ),
                      ],
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: SizedBox(
                      width: double.infinity,
                      key: ValueKey(playerIsSelected.value),
                      child: Visibility(
                        visible: playerIsSelected.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            CustomText(
                              'Choix de la difficulté',
                              textStyle: TextStyles.textMedium.copyWith(
                                fontFamily: 'Parisine Plus Std Clair',
                                fontSize: 20,
                                color: const Color(ColorCode.white3Background),
                                height: 0.6,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomText(
                              'Quelle difficulté ?',
                              textStyle: TextStyles.textLarge.copyWith(
                                fontSize: 40,
                                height: 0.3,
                              ),
                            ),
                            GameDifficultyWidget(
                              title: 'Débutant',
                              color: ColorCode.greenBackground,
                              onTap: () {
                                Get.rootDelegate
                                    .toNamed(Routes.GAME_STATUS, parameters: {
                                  "game_mode":
                                      controller.isChampion.value.toString(),
                                  "points": controller
                                      .qrCodeModel.value.remainingCredit
                                      .toString(),
                                  "player_name": "Michel"
                                });
                              },
                            ),
                            GameDifficultyWidget(
                              title: 'Initié',
                              color: ColorCode.yellow2Background,
                              onTap: () {},
                            ),
                            GameDifficultyWidget(
                              title: 'Expert',
                              color: ColorCode.redBackground,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        playerIsSelected);
  }

  void showAddPlayerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final playerName = "".obs;
          return AlertDialog(
            backgroundColor: const Color(ColorCode.primary),
            title: ObxValue<RxString>(
                (state) => Center(
                      child: CustomText(
                        playerName.value.isNotEmpty
                            ? 'C\'est bien vous ?'
                            : 'Entrez votre nom',
                        textStyle: TextStyles.textLarge.copyWith(
                          fontSize: 24,
                        ),
                      ),
                    ),
                playerName),
            content: Container(
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: CustomTextFormField(
                controller: controller.playerNameController,
                onSubmit: (val) {
                  playerName.value = val;
                },
                hasBorder: true,
                borderColor: ColorCode.whiteBackground,
                borderWidth: 3,
                fontColor: const Color(ColorCode.whiteBackground),
                fontSize: 16,
                hint: 'Typing',
                prefix: const Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 12.0, top: 5, bottom: 5),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            actions: [
              ObxValue<RxString>(
                  (state) => Visibility(
                        visible: playerName.value.isNotEmpty,
                        child: CustomButtonContainer(
                          CustomButton(
                            CustomText(
                              'Non',
                              textStyle: TextStyles.textMedium.copyWith(
                                  color:
                                      const Color(ColorCode.black2Background),
                                  fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            () {
                              controller.playerNameController.clear();
                              Navigator.of(context).pop();
                            },
                            backGroundColor:
                                const Color(ColorCode.white3Background),
                            borderRadius: 4,
                          ),
                          width: 100,
                          height: 55,
                        ),
                      ),
                  playerName),
              ObxValue<RxString>(
                  (state) => Visibility(
                        visible: playerName.value.isNotEmpty,
                        child: CustomButtonContainer(
                          CustomButton(
                            CustomText(
                              'Oui',
                              textStyle: TextStyles.textMedium.copyWith(
                                  color:
                                      const Color(ColorCode.accentLightColor),
                                  fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            () {
                              controller.playerNameController.clear();
                              Navigator.of(context).pop();
                            },
                            backGroundColor:
                                const Color(ColorCode.darkGrayBackground),
                            borderRadius: 4,
                          ),
                          width: 100,
                          height: 55,
                          borderWidth: 2.0,
                          borderColor: ColorCode.accentLightColor,
                        ),
                      ),
                  playerName),
            ],
            actionsAlignment: MainAxisAlignment.center,

            // Message which will be pop up on the screen
          );
        });
  }
}
