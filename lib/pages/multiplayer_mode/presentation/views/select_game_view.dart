import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_host_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/GameWidgetSingleMode.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class MultiplayerSelectGame extends GetView<MultiplayerHostController> {
  const MultiplayerSelectGame({Key? key}) : super(key: key);

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
            onTap: () => Get.rootDelegate.backUntil(Routes.MODE ,popMode: PopMode.History),
            child: const Icon(
              Icons.cancel_outlined,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        backgroundColor:  Color(ColorCode.primaryBackground),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                // isChampion must be called any where to force rebuild
                controller.selectedVariant.value;

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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GameWidgetSingleMode(
                            game: games[index],
                            isChampion: true,
                            selectedVariant: controller.selectedVariant.value,
                            onExitClicked: () =>
                                {controller.selectedVariant.value = null},
                            onGameSelected: (variant) {
                              print(variant.id);
                              controller.selectedGame.value =
                                  games[index].key;
                              controller.selectedVariant.value = variant;
                              // Get.rootDelegate.toNamed(Routes.SELECTED_GAME);
                            },
                            onSelectDifficulty: (int selectedDifficulty) {
                              controller.startGame(
                                  selectedDifficulty);
                              Get.rootDelegate
                                  .toNamed(Routes.MULTIPLAYER_HOST_GAME_STATUS);
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
    );
  }
}
