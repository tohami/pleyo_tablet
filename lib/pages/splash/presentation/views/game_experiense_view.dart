import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_experience_select_item.dart';

import '../controllers/splash_controller.dart';

class GameExperienceView extends GetView<SplashController> {
  const GameExperienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              const GameExperienceSelectItem(
                  borderColor: Color(ColorCode.yellow),
                  titleColor: Color(ColorCode.darkYellow),
                  selectItemAssetUrl: 'assets/images/single_play.png',
                  selectArrowAssetUrl: 'assets/images/yellow_arrow.png',
                  selectTitle: 'Single Play',
                  selectDetails:
                      'Challenge yourself in a solo game and compete with others on the leaderboard.'),
              const SizedBox(
                height: 20,
              ),
              const GameExperienceSelectItem(
                  borderColor: Color(ColorCode.lightBlue),
                  titleColor: Color(ColorCode.darkBlue),
                  selectItemAssetUrl: 'assets/images/group_play.png',
                  selectArrowAssetUrl: 'assets/images/blue_arrow.png',
                  selectTitle: 'Group Play',
                  selectDetails:
                      'Join with friends or family for a group gaming session.'),
              // const SizedBox(
              //   height: 20,
              // ),
              // const GameExperienceSelectItem(
              //     borderColor: Color(ColorCode.lightBlue),
              //     titleColor: Color(ColorCode.darkBlue),
              //     selectItemAssetUrl: 'assets/images/group_play.png',
              //     selectArrowAssetUrl: 'assets/images/blue_arrow.png',
              //     selectTitle: 'Group Play',
              //     selectDetails:
              //     'Join with friends or family for a group gaming session.'),
              //
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(child: Container()),
              const GameExperienceSelectItem(
                  borderColor: Color(ColorCode.darkGreen),
                  titleColor: Color(ColorCode.lightGreen),
                  selectItemAssetUrl: 'assets/images/qr_code.png',
                  selectArrowAssetUrl: 'assets/images/green_arrow.png',
                  selectTitle: 'Scan QR',
                  selectDetails:
                      'Start your game by scanning a QR code for preset games or competitions.'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
