import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/group_rotation/presentation/controllers/group_rotation_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/alert_dialog.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_attempt_item.dart';
import 'package:pleyo_tablet_app/widgets/remake_player_item.dart';

class RemakePlaying extends GetView<GroupRotationController> {
  const RemakePlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGameAttributes = controller.selectedGame.attributes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Quit',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
          titleSpacing: 5,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.cancel_outlined,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                '${controller.playerName} Playing',
                textStyle: TextStyles.textLarge.copyWith(
                  color: const Color(ColorCode.lightGrey),
                ),
              ),
              Expanded(child: Container()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(controller.playersNumber, (index) {
                      if (index == 0) {
                        return RemakePlayerItem(
                          playerImageURl:
                              'assets/images/first_player_image.png',
                          playerName: '${controller.playerName}',
                          attemptNumber: controller.gameAttemptNumbers,
                          isSelected: true,
                          isAttemptFinished: true,
                          isAttemptSelected: true,
                        );
                      }
                      return RemakePlayerItem(
                        playerImageURl: index == 1
                            ? 'assets/images/second_player_image.png'
                            : index == 2
                                ? 'assets/images/third_player_image.png'
                                : index == 3
                                    ? 'assets/images/fourth_player_image.png'
                                    : 'assets/images/fifth_player_image.png',
                        playerName: '${controller.playerName}',
                        attemptNumber: controller.gameAttemptNumbers,
                        isSelected: false,
                        isAttemptFinished: false,
                        isAttemptSelected: false,
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        AlertDialogWidget(
                            content:
                                'You will lose this game’s progress. Sure? ',
                            actionCancelText: 'Quit',
                            actionAcceptText: 'Resume',
                            onCancelClicked: () => {Get.back(result: false)},
                            onAcceptClicked: () => {
                                  Get.rootDelegate.toNamed(Routes.FINAL_RESULT)
                                }),
                      );
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
    );
  }
}
