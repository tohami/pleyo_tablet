import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_experience_select_item.dart';

import '../controllers/splash_controller.dart';

class GameExperienceView extends GetView<SplashController> {
  const GameExperienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    var station = StationService.to.currentStation.attributes ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          titleSpacing: 80.0,
          title: const CustomText(
            'Welcome',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          color: const Color(ColorCode.primaryBackground),
          child: Center(
            child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          'Select Gaming Experience',
                          textStyle: TextStyles.textMedium.copyWith(
                            color: const Color(ColorCode.lightGrey),
                          ),
                        ),

                        Visibility(
                          visible: station?.singlePlayerEnabled == true,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              GameExperienceSelectItem(
                                borderColor: Color(ColorCode.yellow),
                                titleColor: Color(ColorCode.darkYellow),
                                selectItemAssetUrl: 'assets/images/single_play.png',
                                selectArrowAssetUrl: 'assets/images/yellow_arrow.png',
                                selectTitle: 'Single Play',
                                selectDetails:
                                    'Challenge yourself in a solo game and compete with others on the leaderboard.',
                                onTap: () {
                                  Get.rootDelegate.toNamed(Routes.SINGLE_PLAY_LANDING);
                                },
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                          visible: station?.groupEnabled == true,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              StatefulBuilder(builder: (context, setState) {
                                return GameExperienceSelectItem(
                                  borderColor: Color(ColorCode.lightBlue),
                                  titleColor: Color(ColorCode.darkBlue),
                                  selectItemAssetUrl: 'assets/images/group_play.png',
                                  selectArrowAssetUrl: 'assets/images/blue_arrow.png',
                                  selectTitle: 'Group Play',
                                  selectDetails:
                                  'Join with friends or family for a group gaming session.',
                                  onTap: () {
                                    Get.rootDelegate.toNamed(Routes.GROUP_LANDING);
                                  },
                                );
                              }),

                            ],
                          ),
                        ),

                        Visibility(
                          visible: station?.multiplayerEnabled == true,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              GameExperienceSelectItem(
                                borderColor: Color(ColorCode.darkPink),
                                titleColor: Color(ColorCode.lightPink),
                                selectItemAssetUrl: 'assets/images/one_v_one.png',
                                selectArrowAssetUrl: 'assets/images/pink_arrow.png',
                                selectTitle: '1 vs 1 play',
                                selectDetails:
                                'Face off in a head-to-head battle. May the best player win!',
                                onTap: () {  },),

                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(child: Container()),
                        Visibility(
                          visible: station?.competitionEnabled == true,
                          child: GameExperienceSelectItem(
                              borderColor: Color(ColorCode.darkGreen),
                              titleColor: Color(ColorCode.lightGreen),
                              selectItemAssetUrl: 'assets/images/new_qr_code.png',
                              selectArrowAssetUrl:
                                  'assets/images/green_arrow.png',
                              selectTitle: 'Scan QR',
                              selectDetails:
                                  'Start your game by scanning a QR code for preset games or competitions.',
                              onTap: () {
                                Get.rootDelegate.offNamed(Routes.SCAN_QR);
                                // Get.offNamed(Routes.SELECT_TEAM_SIZE);
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
          ),
        ),
      ),
    );
  }
}
