import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/GameWidgetSingleMode.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';
import 'package:pleyo_tablet_app/widgets/player_name.dart';
import 'package:pleyo_tablet_app/widgets/start_game_bottom_sheet.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {

  const HomeView({Key? key}) : super(key: key);

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
            onTap: () => Get.rootDelegate.backUntil(Routes.SCAN_QR ,popMode: PopMode.History),
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

                if(controller.games.isNotEmpty) {
                  var games = controller.games.entries.toList();

                  games.sort(((a, b) => a.key.attributes!.gamehubId! - b.key.attributes!.gamehubId!)) ;
                  return ListView.builder(
                    itemCount: games.length,
                    shrinkWrap: true,
                    clipBehavior: Clip.none ,
                    physics: const NeverScrollableScrollPhysics() ,
                    itemBuilder: (context , index) {
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
                            },
                          ),



                          // GameWidget(game: games[index],isChampion: controller.isChampoinship.value,onPlayClicked: (variant) {
                          //   print(variant.toJson()) ;
                          //   showBottomSheetModal(context , variant , (diff) {
                          //     controller.startGame( diff);
                          //   }) ;
                          // },) ,
                          const SizedBox(
                            height: 30,
                          ),


                        ],
                      ) ;
                    },
                  ) ;
                }else {
                  return Container() ;
                }

              }),
            ],
          ),
        ),
      ),
    );
  }


  showBottomSheetModal(BuildContext context , GameVariant variation,Function(int) onDifficultSelected) {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StartGameBottomSheet(
              controller: controller,
              gameVariation: variation,
              onDifficultSelected: onDifficultSelected,
            ),
          ],
        ) ,
        backgroundColor: const Color(ColorCode.darkGrayBackground),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        isScrollControlled: true) ;
  }

}
