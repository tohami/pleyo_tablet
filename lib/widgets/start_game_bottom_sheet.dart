import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/game_model.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_widget.dart';
import 'package:pleyo_tablet_app/widgets/player_widget.dart';

class StartGameBottomSheet extends StatelessWidget {
  final HomeController controller;
  final VariationList gameVariation;
  final Function(int) onDifficultSelected;
  StartGameBottomSheet(
      {required this.controller,
      required this.gameVariation,
      required this.onDifficultSelected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gameDifficulties =
        gameVariation.difficultyAvailable!.map((e) => e.difficulty ?? "");
    print(gameDifficulties);
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 56, vertical: 66),
          // height: playerIsSelected.value ? 500 : 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomText(
                            'Choose your level',
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
                            'Which level?',
                            textStyle: TextStyles.textLarge.copyWith(
                              fontSize: 40,
                              height: 0.3,
                            ),
                          ),
                          gameDifficulties.contains("0")
                              ? GameDifficultyWidget(
                                  title: 'Easy',
                                  color: ColorCode.greenBackground,
                                  onTap: () {
                                    onDifficultSelected(0);
                                  },
                                )
                              : Container(),
                          gameDifficulties.contains("1")
                              ? GameDifficultyWidget(
                                  title: 'Medium',
                                  color: ColorCode.yellow2Background,
                                  onTap: () {
                                    onDifficultSelected(
                                        1);
                                  },
                                )
                              : Container(),
                          gameDifficulties.contains("2")
                              ? GameDifficultyWidget(
                                  title: 'Hard',
                                  color: Colors.deepOrange.value,
                                  onTap: () {
                                    onDifficultSelected(
                                        2);
                                  },
                                )
                              : Container(),
                          gameDifficulties.contains("3")
                              ? GameDifficultyWidget(
                                  title: 'Very hard',
                                  color: ColorCode.redBackground,
                                  onTap: () {
                                    onDifficultSelected(
                                        3);
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
              )
            ],
          ),
        );
  }

}
