import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
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
        backgroundColor: const Color(ColorCode.primary),
        body: SingleChildScrollView(
         physics: const ClampingScrollPhysics(),
          child: Container(
            color: const Color(ColorCode.primary),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        playerNameWidget(playerName: controller.ticket.attributes!.nickname! ,onLogoutClicked:  ()=>controller.onLogoutClicked()),
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  // isChampion must be called any where to force rebuild
                  controller.isChampoinship.value;


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
                          // key: ValueKey("${}"),
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            GameWidget(game: games[index],isChampion: controller.isChampoinship.value,onGameSelected: (variant) {
                              print(variant.toJson()) ;
                              showBottomSheetModal(context , variant , (diff) {
                                controller.startGame(variant.id!, diff);
                              }) ;
                            },) ,

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
