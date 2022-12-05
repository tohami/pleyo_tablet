import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_widget.dart';
import 'package:pleyo_tablet_app/widgets/player_widget.dart';

class StartGameBottomSheet extends StatelessWidget {
  final HomeController controller;
  final GameVariant gameVariation;
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
        gameVariation.attributes?.gameDifficulties?.data;
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
                          ...gameDifficulties!.map((e)  {
                            return GameDifficultyWidget(
                                title: e.attributes!.name!,
                                color: ColorCode.greenBackground,
                                onTap: () {
                                onDifficultSelected(e.id!);
                                }) ;
                          }).toList() ,
                        ],
                      ),
                    ),
              )
            ],
          ),
        );
  }

}
