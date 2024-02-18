import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/controllers/single_player_mode_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';

class Welcome extends GetView<SinglePlayerModeController> {
  const Welcome({Key? key}) : super(key: key);

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
        body: GestureDetector(
          onTap: () => Get.rootDelegate.toNamed(Routes.SINGLE_MODE_SELECT_GAME),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  'Your name',
                  textStyle: TextStyles.textMedium.copyWith(
                    color: const Color(ColorCode.lightGrey),
                    fontFamily: 'CoconPro',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomText(
                  'Welcome',
                  textStyle: TextStyles.textXXLarge.copyWith(
                    fontFamily: 'CoconPro',
                    color: const Color(ColorCode.aqua),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 110,
                  width: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(ColorCode.black),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 3.0, color: const Color(ColorCode.grey5)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(ColorCode.shadowColor),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: CustomText(
                    '${controller.currentPlayer?.attributes?.nickname}',
                    textStyle: TextStyles.textXXLarge.copyWith(
                      fontFamily: 'Helvetica Neue',
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Image.asset('assets/images/single_play.png',
                    height: 185, width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
