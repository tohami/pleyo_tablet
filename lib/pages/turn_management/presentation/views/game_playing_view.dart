import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/controllers/group_rotation_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/alert_dialog.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_attempt_item.dart';
import 'package:pleyo_tablet_app/widgets/remake_player_item.dart';

class GamePlaying extends GetView<GroupRotationController> {
  const GamePlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(ColorCode.primaryBackground),
            // title: const CustomText(
            //   'Quit',
            //   textStyle: TextStyles.textSmall,
            //   textAlign: TextAlign.start,
            // ),
            // titleSpacing: 5,
            // leading: GestureDetector(
            //   onTap: () => controller.stopGame(),
            //   child: const Icon(
            //     Icons.cancel_outlined,
            //     color: Color(ColorCode.darkGrey),
            //     size: 35,
            //   ),
            // ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  '${controller.currentPlayer.value?.nickname} Playing',
                  textStyle: TextStyles.textLarge.copyWith(
                    color: const Color(ColorCode.lightGrey),
                  ),
                ),
                Expanded(child: Container()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children : (controller.players..sort((a , p) => a.playOrder! - p.playOrder!)).map((player) {
                        var scores = controller.getPlayerScores(player) ;
                        return RemakePlayerItem(
                          playerImageURl: player.avatar?.data?.attributes?.url??"",
                          playerName: '${player.nickname}',
                          totalTurns: controller.numberOfTurns,
                          currentTurn: scores.length,
                          playing: controller.currentPlayer.value?.id == player.id,
                        );
                      }).toList()
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.stopGame("GroupGamePlayingScreen:user click on Quite button") ;
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.0, 0.055),
                            end: Alignment(0.699, 0.0),
                            colors: [
                              Color(ColorCode.black),
                              Color(ColorCode.primaryBackground)
                            ],
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(36.0),
                          border: Border.all(
                              width: 5.0, color: const Color(ColorCode.aqua)),
                        ),
                        child: CustomText(
                          'Quit',
                          textStyle: TextStyles.textXXLarge.copyWith(
                            color: const Color(ColorCode.lightGrey6),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
