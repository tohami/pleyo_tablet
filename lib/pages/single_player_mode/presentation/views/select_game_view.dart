import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/controllers/single_player_mode_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';

class SelectGame extends GetView<SinglePlayerModeController> {
  const SelectGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Exit the session',
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
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  'Select Game',
                  textStyle: TextStyles.textMedium.copyWith(
                    fontFamily: 'CoconPro',
                    color: const Color(ColorCode.lightGrey6),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() {
                  if (controller.games.isNotEmpty) {
                    var games = controller.games.entries.toList();

                    games.sort(((a, b) =>
                        a.key.attributes!.gamehubId! -
                        b.key.attributes!.gamehubId!));
                    return ListView.builder(
                      itemCount: games.length,
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GameWidget(
                              game: games[index],
                              isChampion: false,
                              onPlayClicked: (variant) {
                                print(variant.toJson());

                                controller.selectedGame.value = variant;
                                Get.rootDelegate.toNamed(Routes.SELECTED_GAME);

                                /*showBottomSheetModal(context, variant,
                                            (diff) {
                                          controller.startGame(variant.id!, diff);
                                        });*/
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
