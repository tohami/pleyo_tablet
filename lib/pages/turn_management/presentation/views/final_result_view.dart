import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/controllers/group_rotation_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';
import 'package:pleyo_tablet_app/widgets/player_result_item.dart';
import 'package:pleyo_tablet_app/widgets/player_score_item.dart';
import "package:collection/collection.dart";

class FinalResult extends GetView<GroupRotationController> {
  final List<Color> borderColors = [
    Color(ColorCode.pink), // For Rossana
    Color(ColorCode.aqua2), // For Spike
    Color(ColorCode.yellow4), // For Bahhnaa
    Color(ColorCode.red3), // For One
    Color(ColorCode.green2), // For Erith
  ];

  final List<List<Color>> gradientColors = [
    [Color(ColorCode.pink2), Color(ColorCode.pink3)], // For Rossana
    [Color(ColorCode.aqua3), Color(ColorCode.aqua4)], // For Spike
    [Color(ColorCode.yellow2), Color(ColorCode.yellow3)], // For Bahhnaa
    [Color(ColorCode.red), Color(ColorCode.red2)], // For One
    [Color(ColorCode.green3), Color(ColorCode.green4)], // For Erith
  ];

  FinalResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onTap: () => Get.rootDelegate.backUntil(Routes.GROUP_TURN_RESULT),
            child: const Icon(
              Icons.cancel_outlined,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        body: Obx(() {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !controller.isEmailAdded.value,
                  child: CustomText(
                    controller.isEmailValid.value
                        ? 'Well Played'
                        : 'Stay on contact',
                    textStyle: TextStyles.textLarge.copyWith(
                      color: const Color(ColorCode.lightGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Visibility(
                  visible: !controller.isEmailEnabled.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.leaderBoardList.mapIndexed((index, item) {

                        return PlayerScoreItem(
                          playerName: item.playerNickName??"",
                          playerScore: item.score.toString(),
                          containerGradient: LinearGradient(
                            begin: Alignment(-0.778, 0.0),
                            end: Alignment(1.19, 0.0),
                            colors: gradientColors[index],
                            stops: [0.0, 1.0],
                          ),
                          imageBorderColor: borderColors[index],
                        imageUrl: item.avatarUrl ??
                            "",
                      );
                    }).toList(),
                  ),
                ),
                Expanded(child: Container()) ,
                Visibility(
                  visible: controller.isEmailEnabled.value,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      List.generate(controller.numberOfPlayers, (index) {
                        return PlayerResultItem(
                          isEnabled: controller.isEmailAdded.value,
                          playerImageURl: index == 0
                              ? 'assets/images/first_player_image.png'
                              : index == 1
                              ? 'assets/images/second_player_image.png'
                              : index == 2
                              ? 'assets/images/third_player_image.png'
                              : index == 3
                              ? 'assets/images/fourth_player_image.png'
                              : 'assets/images/fifth_player_image.png',
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: !controller.isEmailAdded.value,
                  child: Stack(
                      alignment: Alignment.bottomRight,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.only(
                              left: 20, right: 50, top: 20, bottom: 40),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-1.0, -0.108),
                              end: Alignment(1.0, -0.139),
                              colors: [
                                Color(ColorCode.black),
                                Color(ColorCode.primary),
                                Color(ColorCode.black),
                              ],
                              stops: [0.0, 0.433, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'Get scores by email.',
                                textStyle: TextStyles.textSmall.copyWith(
                                    color: const Color(ColorCode.lightGrey9),
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    'E-mail',
                                    textStyle: TextStyles.textSmall.copyWith(
                                      fontFamily: 'Helvetica Neue',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                      controller.isEmailEnabled.value =
                                      !controller.isEmailEnabled.value,
                                      child: Container(
                                        height: 46,
                                        child: CustomTextField(
                                          hintText: 'tap to enter your email',
                                          controller:
                                          controller.groupEmailController,
                                          keyboardType: TextInputType.text,
                                          fontStyle:
                                          TextStyles.textSmall.copyWith(
                                            fontFamily: 'Helvetica Neue',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          isEnabled:
                                          controller.isEmailEnabled.value,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 90,
                          top: 130,
                          child: Visibility(
                            visible: controller.isEmailEnabled.value,
                            child: GestureDetector(
                              onTap: () =>
                              {controller.isEmailAdded.value = true},
                              child: Container(
                                width: 120,
                                height: 60,
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
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    width: 4.0,
                                    color: controller.isEmailValid.value
                                        ? const Color(ColorCode.aqua)
                                        : const Color(ColorCode.grey),
                                  ),
                                ),
                                child: CustomText(
                                  'Yes',
                                  textStyle: TextStyles.textSmall.copyWith(
                                    color: controller.isEmailValid.value
                                        ? const Color(ColorCode.aqua)
                                        : const Color(ColorCode.lightGrey6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Visibility(
                  visible: controller.isEmailAdded.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        'Thank You',
                        textStyle: TextStyles.textXXLarge.copyWith(
                            fontFamily: 'CoconPro',
                            fontSize: 60,
                            color: const Color(ColorCode.aqua),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        'Success! Your Scores link are on their way.',
                        textStyle: TextStyles.textSmall.copyWith(
                            fontFamily: 'Helvetica Neue',
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        controller.groupEmailController.text,
                        textStyle: TextStyles.textMedium.copyWith(
                            fontFamily: 'Helvetica Neue',
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () => {
                        Get.rootDelegate.toNamed(Routes.SPLASH)
                      },
                        child: Container(
                          width: 200,
                          height: 120,
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
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(
                                width: 4.0, color: const Color(ColorCode.aqua)),
                          ),
                          child: CustomText(
                            'Exit',
                            textStyle: TextStyles.textXXLarge.copyWith(
                              color: const Color(ColorCode.lightGrey6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
