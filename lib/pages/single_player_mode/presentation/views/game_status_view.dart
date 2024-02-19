import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/controllers/single_player_mode_controller.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/controllers/group_rotation_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class SingleModeGameStatus extends GetView<SinglePlayerModeController> {
  const SingleModeGameStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGameAttributes = controller.selectedVariant.value!.attributes!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Exit',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
          titleSpacing: 5,
          leading: GestureDetector(
            onTap: () => controller.stopGame(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        body: Container(
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ObxValue<RxBool>((gameFail) {
                return CustomText(
                  'Go',
                  textStyle: TextStyles.textXXXLarge.copyWith(
                    fontSize: 100,
                    color: gameFail.value
                        ? const Color(ColorCode.lightGrey8)
                        : const Color(ColorCode.grey3),
                    // fontWeight: FontWeight.w700,
                  ),
                );
              }, controller.gameFail),
              ObxValue<RxBool>((gameFail) {
                return Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: [
                      Positioned(
                        top: 300,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              height: 300,
                              width: 700,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    selectedGameAttributes.image?.data?.attributes?.url??"",
                                  ),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.19),
                                      BlendMode.dstIn),
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(ColorCode.shadowColor3),
                                    offset: Offset(15, 15),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      gameFail.value
                          ? Positioned(
                              top: 300,
                              child: InkWell(
                                onTap: ()=>controller.startGame(controller.selectedDifficulty!),
                                child: Container(
                                  width: 200,
                                  height: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(-1.0, 0.055),
                                      end: Alignment(0.699, 0.0),
                                      colors: [
                                        Color(ColorCode.black),
                                        Color(ColorCode.primaryBackground)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                    borderRadius: BorderRadius.circular(36.0),
                                    border: Border.all(
                                        width: 5.0,
                                        color: const Color(0xff2ff7f7)),
                                  ),
                                  child: CustomText(
                                    'Retry',
                                    textStyle: TextStyles.textXXLarge.copyWith(
                                      color: const Color(ColorCode.lightGrey6),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              top: 300,
                              child: GestureDetector(
                                onTap: () => Get.rootDelegate
                                    .toNamed(Routes.GROUP_TURN_GAME_PLAY),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      'assets/images/go_arrow.png',
                                      width: 100,
                                      height: 80,
                                    )
                                        .animate(
                                            onPlay: (controller) => controller
                                                .repeat(reverse: true))
                                        .moveY(
                                            curve: Curves.ease,
                                            begin: 1,
                                            end: -200,
                                            delay: 700.ms,
                                            duration: 900.ms),
                                    const SizedBox(
                                      height: 150,
                                    ),
                                    CustomText(
                                      'Game Starting!',
                                      textStyle: TextStyles.textLarge.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              }, controller.gameFail),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
