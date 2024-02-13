import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_attempt_item.dart';

class RemakePlayerItem extends StatelessWidget {
  final String playerImageURl;
  final String playerName;
  final int attemptNumber;
  final bool isAttemptFinished;
  final bool isAttemptSelected;
  final bool isSelected;

  const RemakePlayerItem(
      {Key? key,
      required this.playerImageURl,
      required this.isSelected,
      required this.attemptNumber,
      required this.playerName,
      required this.isAttemptFinished,
      required this.isAttemptSelected})
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
                Image.asset(
                  playerImageURl,
                  width: 80,
                  height: 80,
                ),
                Visibility(
                  visible: !isSelected,
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
                  visible: isSelected,
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
            children: List.generate(attemptNumber, (index) {
              if (index == 0) {
                return GameAttemptItem(
                  isSelected: isAttemptSelected,
                  isAttemptFinished: isAttemptFinished,
                );
              }
              return const GameAttemptItem();
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
