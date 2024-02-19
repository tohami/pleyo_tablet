import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/group_video_widget.dart';
import 'package:pleyo_tablet_app/widgets/scaled_game_widget.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_text.dart';

class GameWidgetSingleMode extends StatelessWidget {
  final Function(GameVariant) onGameSelected;
  final bool isChampion;
  final GameVariant? selectedVariant;
  final VoidCallback onExitClicked;
  final Function(int selectedDifficulty) onSelectDifficulty;

  final MapEntry<Game, List<GameVariant>> game;

  const GameWidgetSingleMode({
    required this.isChampion,
    required this.game,
    required this.onGameSelected,
    this.selectedVariant,
    required this.onExitClicked,
    Key? key,
    required this.onSelectDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 84,
          width: 300,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.973, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                Color(ColorCode.primaryBackground),
                Color(ColorCode.black3),
                Color(ColorCode.primaryBackground),
              ],
              stops: [0.0, 0.325, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: CustomText(
                  game.key.attributes?.name ?? "",
                  textStyle: TextStyles.textLarge.copyWith(
                    color: const Color(ColorCode.lightGrey4),
                  ),
                ),
              ),
              Container(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: game.value.map((gameVariant) {
                    if (selectedVariant?.id == gameVariant.id) {
                      return Container(
                        padding: EdgeInsets.only(right: 10),
                        child: ScaledGameWidget(
                          gameImageUrl: gameVariant.attributes!.image!.data!
                              .attributes!.formats!.thumbnail!.url!,
                          gameName: gameVariant.attributes!.name!,
                          gameDifficultiesList:
                              gameVariant.attributes!.gameDifficulties!.data,
                          onExitClicked: onExitClicked,
                          onSelectDifficulty: (int selectedDifficulty) {
                            this.onSelectDifficulty(selectedDifficulty);
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: GroupVideoWidget(
                          gameVariant,
                          onTap: () {
                            onGameSelected(gameVariant);
                          },
                          key: const ValueKey(1),
                        ),
                      );
                    }
                  }).toList(),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
