import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/controllers/group_select_steps_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';
import 'package:pleyo_tablet_app/widgets/group_game_widget.dart';

import '../../../../services/InactivityRedirectService.dart';

class SelectGameStep extends GetView<GroupPlayStepsController> {
  const SelectGameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Back',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
          titleSpacing: 5,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        backgroundColor: const Color(ColorCode.primaryBackground),
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
                controller.isChampoinship.value;

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
                          GroupGameWidget(
                            game: games[index],
                            isChampion: controller.isChampoinship.value,
                            onGameSelected: (variant) {
                              Get.find<InactivityRedirectService>().userInteracted() ;
                              controller.selectedGameVariant.value=variant;
                              controller.selectedGame = games[index].key;
                              Get.rootDelegate.toNamed("${Routes.GROUP_LANDING}/${Routes.GROUP_SELECTED_GAME_DETAILS}");
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
