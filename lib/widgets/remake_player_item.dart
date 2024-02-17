import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_attempt_item.dart';

class RemakePlayerItem extends StatelessWidget {
  final String playerImageURl;
  final String playerName;
  final int currentTurn;
  final int totalTurns;
  final bool playing;

  const RemakePlayerItem(
      {Key? key,
      required this.playerImageURl,
      required this.currentTurn,
      required this.totalTurns,
      required this.playerName,
      required this.playing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 180,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: playerImageURl,
                  width: 80,
                  height: 80,
                ),
                Visibility(
                  visible: !playing,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color(ColorCode.shadowColor),
                        offset: Offset(0, 6),
                        blurRadius: 12,
                      ),
                    ]),
                  ),
                ),
                Visibility(
                  visible: playing,
                  child: Image.asset(
                     'assets/images/icon_downloading.png',
                    width: 100,
                    height: 100,
                  )
                      .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: false))
                      .rotate(
                          curve: Curves.slowMiddle,
                          begin: 0,
                          end: 1,
                          duration: 1500.ms),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(totalTurns, (index) {
              if (index < currentTurn) {
                return GameAttemptItem(
                  isSelected: playing,
                  isAttemptFinished: true,
                );
              }
              return GameAttemptItem(
                isSelected: playing,
                isAttemptFinished: false,
              );
            }),
          ),
          CustomText(
            playerName,
            textStyle: TextStyles.textMedium.copyWith(
              fontFamily: 'Helvetica',
              color: const Color(ColorCode.extraLightGrey),
            ),
          )
        ],
      ),
    );
  }
}
