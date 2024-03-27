import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/group_number_select_item.dart';

import '../controllers/group_select_steps_controller.dart';

// ignore: must_be_immutable
class SelectTeamSizeStep extends GetView<GroupPlayStepsController> {
  final imageAssets = [
    'assets/images/group_number_yellow_arrow.png',
    'assets/images/group_number_pink_arrow.png',
    'assets/images/group_number_blue_arrow.png',
    'assets/images/group_number_green_arrow.png',
  ] ;
  final titleColors = [
    ColorCode.darkYellow ,
    ColorCode.lightPink ,
    ColorCode.darkBlue ,
    ColorCode.lightGreen ,
  ] ;

  final borderColors = [
    ColorCode.yellow ,
    ColorCode.darkPink ,
    ColorCode.lightBlue ,
    ColorCode.darkGreen ,
  ] ;

  SelectTeamSizeStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var groupTemplated = StationService.to.currentStation.attributes?.organization?.data?.attributes?.configuration?.data?.attributes?.groupTemplates ;

    FocusManager.instance.primaryFocus?.unfocus();
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                'Pick your team size',
                textStyle: TextStyles.textMedium.copyWith(
                  color: const Color(ColorCode.lightGrey),
                  fontFamily: 'CoconPro',
                ),
              )
                  .animate(
                      onPlay: (controller) => controller.repeat(reverse: true))
                  .moveY(
                      curve: Curves.ease,
                      begin: 1,
                      end: 12,
                      delay: 700.ms,
                      duration: 900.ms),
              const SizedBox(
                height: 100,
              ),
              CustomText(
                'How many are joining the fun?',
                textStyle: TextStyles.textSmall.copyWith(
                  color: const Color(ColorCode.white),
                  fontFamily: 'Helvetica',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(10.0),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: groupTemplated?.map((e) {
                    var index = groupTemplated.indexOf(e) ;
                    return GroupNumberSelectItem(
                      borderColor: Color(borderColors[index]),
                      titleColor: Color(titleColors[index]),
                      selectArrowAssetUrl: imageAssets[index],
                      selectNumber: e.numberOfPlayers.toString(),
                      turnsNumber: e.numberOfTurns.toString(),
                      gameDuration: (e.numberOfTurns! * e.numberOfPlayers! * 2.5).toString(),
                      onTap: () {
                        controller.updateTemplate(e);
                        Get.rootDelegate.toNamed("${Routes.GROUP_LANDING}/${Routes.GROUP_TEAM_NAME}");
                      },
                    ) ;
                  }).toList() ?? []
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
