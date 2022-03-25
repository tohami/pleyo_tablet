import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_widget.dart';
import 'package:pleyo_tablet_app/widgets/player_widget.dart';

class StartGameBottomSheet extends StatelessWidget {
  HomeController controller;

  StartGameBottomSheet({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 56, vertical: 66),
          width: Get.width,
          height: 500,
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
                width: Get.width,
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PlayerWidget(
                      addPlayer: true,
                      onTap: () {},
                    ),
                    PlayerWidget(
                      playerName: 'Kévin',
                      onTap: () {
                        controller.changePlayerSelection(
                            !controller.playerIsSelected.value);
                      },
                    ),
                    PlayerWidget(
                      playerName: 'Michel',
                      onTap: () {
                        controller.changePlayerSelection(
                            !controller.playerIsSelected.value);
                      },
                    ),
                  ],
                ),
              ),
              ObxValue((state) {
                return Visibility(
                  visible: controller.playerIsSelected.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        onTap: () {},
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
                );
              }, controller.playerIsSelected)
            ],
          ),
        ));
  }
}
