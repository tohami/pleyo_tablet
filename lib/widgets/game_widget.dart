import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import '../model/game_model.dart';
import 'custom_text.dart';

class GameWidget extends StatelessWidget {
  final Function(VariationList) onPlayClicked;
  final bool isChampion ;
  final GameModel game;

  const GameWidget({ required this.isChampion, required this.game,required this.onPlayClicked ,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          game.gameName??"",
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
            itemCount: game.variationList?.length,
            itemBuilder: (context , index) {
              return VideoWidget(
                game.variationList![index],
                buttonColor: isChampion
                    ? ColorCode.customAccent2Background
                    : ColorCode.yellow3Background,
                onTap: () {
                  onPlayClicked(game.variationList![index]);
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
