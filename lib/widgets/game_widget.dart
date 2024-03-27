import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_text.dart';

class GameWidget extends StatelessWidget {
  final Function(GameVariant) onPlayClicked;
  final bool isChampion ;
  final MapEntry<Game , List<GameVariant>> game;

  const GameWidget({ required this.isChampion, required this.game,required this.onPlayClicked ,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          game.key.attributes?.name??"",
          textStyle: TextStyles.textLarge.copyWith(
            fontSize: 40,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 260,
          child: ListView.builder(
            clipBehavior: Clip.none ,
            scrollDirection: Axis.horizontal,
            itemCount: game.value.length,
            itemBuilder: (context , index) {
              return VideoWidget(
                game.value[index],
                buttonColor: isChampion
                    ? ColorCode.customAccent2Background
                    : ColorCode.yellow3Background,
                onTap: () {
                  onPlayClicked(game.value[index]);
                },
                key: const ValueKey(1),
              ) ;
            },
          ),
        ),
      ],
    );
  }
}
