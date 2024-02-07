import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/controllers/group_select_steps_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';
import 'package:pleyo_tablet_app/widgets/player_name_item.dart';

class GroupNamesStep extends GetView<GroupPlayStepsController> {
  const GroupNamesStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Back to select the team',
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
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            controller.selectedItem.value = -1;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            color: const Color(ColorCode.primaryBackground),
            child: ObxValue<RxInt>((selectedItem) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/group_name_header_bg.png',
                      ),
                      CustomText(
                        controller.teamNameController.text,
                        textStyle: TextStyles.textXLarge.copyWith(
                          color: const Color(ColorCode.lightGrey4),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectedItem.value != -1
                      ? Container()
                      : CustomText(
                          'Each player has an assigned name. \nAll set for action! ',
                          textStyle: TextStyles.textSmall.copyWith(
                            fontFamily: 'Helvetica Neue',
                            color: const Color(ColorCode.white2),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedItem.value = 0;
                    },
                    child: PlayerNameItem(
                      containerGradient: const LinearGradient(
                        begin: Alignment(-0.778, 0.0),
                        end: Alignment(1.19, 0.0),
                        colors: [
                          Color(ColorCode.pink2),
                          Color(ColorCode.pink3)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      imageBorderColor: const Color(ColorCode.pink),
                      nameColor: const Color(ColorCode.pink4),
                      imageUrl: 'assets/images/first_player_image.png',
                      playerNumber: 1,
                      name: controller.playerName1Controller.text.isEmpty
                          ? "Rosana"
                          : controller.playerName1Controller.text,
                      controller: controller.playerName1Controller,
                      isItemSelected: controller.selectedItem.value == 0,
                      hasSelectedItem: controller.selectedItem.value != -1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedItem.value = 1;
                    },
                    child: PlayerNameItem(
                      containerGradient: const LinearGradient(
                        begin: Alignment(-0.955, 0.0),
                        end: Alignment(1.15, 0.0),
                        colors: [
                          Color(ColorCode.aqua3),
                          Color(ColorCode.aqua4)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      imageBorderColor: const Color(ColorCode.aqua2),
                      nameColor: const Color(ColorCode.aqua2),
                      imageUrl: 'assets/images/second_player_image.png',
                      playerNumber: 2,
                      name: controller.playerName2Controller.text.isEmpty
                          ? "Spike"
                          : controller.playerName2Controller.text,
                      controller: controller.playerName2Controller,
                      isItemSelected: controller.selectedItem.value == 1,
                      hasSelectedItem: controller.selectedItem.value != -1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedItem.value = 2;
                    },
                    child: PlayerNameItem(
                      containerGradient: const LinearGradient(
                        begin: Alignment(-0.958, 0.0),
                        end: Alignment(1.249, 0.0),
                        colors: [
                          Color(ColorCode.yellow2),
                          Color(ColorCode.yellow3)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      imageBorderColor: const Color(ColorCode.yellow4),
                      nameColor: const Color(ColorCode.yellow5),
                      imageUrl: 'assets/images/third_player_image.png',
                      playerNumber: 3,
                      name: controller.playerName3Controller.text.isEmpty
                          ? "Bahhnaa"
                          : controller.playerName3Controller.text,
                      controller: controller.playerName3Controller,
                      isItemSelected: controller.selectedItem.value == 2,
                      hasSelectedItem: controller.selectedItem.value != -1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedItem.value = 3;
                    },
                    child: PlayerNameItem(
                      containerGradient: const LinearGradient(
                        begin: Alignment(-1.0, 0.0),
                        end: Alignment(1.265, 0.0),
                        colors: [Color(ColorCode.red), Color(ColorCode.red2)],
                        stops: [0.0, 1.0],
                      ),
                      imageBorderColor: const Color(ColorCode.red3),
                      nameColor: const Color(ColorCode.red4),
                      imageUrl: 'assets/images/fourth_player_image.png',
                      playerNumber: 4,
                      name: controller.playerName4Controller.text.isEmpty
                          ? "One"
                          : controller.playerName4Controller.text,
                      controller: controller.playerName4Controller,
                      isItemSelected: controller.selectedItem.value == 3,
                      hasSelectedItem: controller.selectedItem.value != -1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectedItem.value = 4;
                    },
                    child: PlayerNameItem(
                      containerGradient: const LinearGradient(
                        begin: Alignment(-0.968, 0.0),
                        end: Alignment(1.206, 0.0),
                        colors: [
                          Color(ColorCode.green3),
                          Color(ColorCode.green4)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      imageBorderColor: const Color(ColorCode.green2),
                      nameColor: const Color(ColorCode.green),
                      imageUrl: 'assets/images/fifth_player_image.png',
                      playerNumber: 5,
                      name: controller.playerName5Controller.text.isEmpty
                          ? "Erith"
                          : controller.playerName5Controller.text,
                      controller: controller.playerName5Controller,
                      isItemSelected: controller.selectedItem.value == 4,
                      hasSelectedItem: controller.selectedItem.value != -1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      'Tap any name to edit.',
                      textStyle: TextStyles.textXSmall.copyWith(
                        color: const Color(ColorCode.lightGrey5),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: 75,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(-1.0, 0.0),
                        end: Alignment(1.0, 0.0),
                        colors: [
                          Color(ColorCode.white3),
                          Color(ColorCode.black2)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(56.0),
                      border: Border.all(
                          width: 6.0, color: const Color(ColorCode.aqua)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          'Select Game',
                          textStyle: TextStyles.textMedium.copyWith(
                            fontFamily: 'CoconPro',
                            color: const Color(ColorCode.aqua),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/images/lets_play_arrow.png',
                          width: 40,
                          height: 25,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }, controller.selectedItem),
          ),
        ),
      ),
    );
  }
}
