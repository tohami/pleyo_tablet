import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_text.dart';

class GameWidget extends StatelessWidget {
  final Function(GameVariant) onGameSelected;
  final bool isChampion;

  final MapEntry<Game, List<GameVariant>> game;

  const GameWidget(
      {required this.isChampion,
      required this.game,
      required this.onGameSelected,
      Key? key})
      : super(key: key);

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
                height: 175,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: game.value.length,
                  itemBuilder: (context, index) {
                    return VideoWidget(
                      game.value[index],
                      buttonColor: isChampion
                          ? ColorCode.customAccent2Background
                          : ColorCode.yellow3Background,
                      onTap: () {
                        onGameSelected(game.value[index]);
                      },
                      key: const ValueKey(1),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
