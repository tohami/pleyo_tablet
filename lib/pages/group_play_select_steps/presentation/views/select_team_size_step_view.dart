import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/group_number_select_item.dart';

import '../controllers/group_select_steps_controller.dart';

// ignore: must_be_immutable
class SelectTeamSizeStep extends GetView<GroupPlayStepsController> {
  const SelectTeamSizeStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
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
                  children: <Widget>[
                    GroupNumberSelectItem(
                      borderColor: Color(ColorCode.yellow),
                      titleColor: Color(ColorCode.darkYellow),
                      selectArrowAssetUrl:
                          'assets/images/group_number_yellow_arrow.png',
                      selectNumber: '2',
                      turnsNumber: '2',
                      gameDuration: '10',
                      onTap: () {
                        controller.updateTeamSize(2);
                        Get.rootDelegate.toNamed(Routes.ADD_TEAM_NAME);
                      },
                    ),
                    GroupNumberSelectItem(
                      borderColor: Color(ColorCode.darkPink),
                      titleColor: Color(ColorCode.lightPink),
                      selectArrowAssetUrl:
                          'assets/images/group_number_pink_arrow.png',
                      selectNumber: '3',
                      turnsNumber: '2',
                      gameDuration: '10',
                      onTap: () {
                        controller.updateTeamSize(3);
                        Get.rootDelegate.toNamed(Routes.ADD_TEAM_NAME);
                      },
                    ),
                    GroupNumberSelectItem(
                      borderColor: Color(ColorCode.lightBlue),
                      titleColor: Color(ColorCode.darkBlue),
                      selectArrowAssetUrl:
                          'assets/images/group_number_blue_arrow.png',
                      selectNumber: '4',
                      turnsNumber: '2',
                      gameDuration: '10',
                      onTap: () {
                        controller.updateTeamSize(4);
                        Get.rootDelegate.toNamed(Routes.ADD_TEAM_NAME);
                      },
                    ),
                    GroupNumberSelectItem(
                      borderColor: Color(ColorCode.darkGreen),
                      titleColor: Color(ColorCode.lightGreen),
                      selectArrowAssetUrl:
                          'assets/images/group_number_green_arrow.png',
                      selectNumber: '5',
                      turnsNumber: '2',
                      gameDuration: '10',
                      onTap: () {
                        controller.updateTeamSize(5);
                        Get.rootDelegate.toNamed(Routes.ADD_TEAM_NAME);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
