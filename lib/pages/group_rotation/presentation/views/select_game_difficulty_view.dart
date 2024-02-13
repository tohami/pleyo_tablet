import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/controllers/group_select_steps_controller.dart';
import 'package:pleyo_tablet_app/pages/group_rotation/presentation/controllers/group_rotation_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_attempt_item.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_item.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';

class SelectGameDifficulty extends GetView<GroupRotationController> {
  const SelectGameDifficulty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGameAttributes = controller.selectedGame.attributes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Quit',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
          titleSpacing: 5,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.cancel_outlined,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        body: Container(
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'Welcome',
                    textStyle: TextStyles.textMedium.copyWith(
                      fontFamily: 'CoconPro',
                      color: const Color(ColorCode.lightGrey4),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  CustomText(
                    ' 1.RayMak',
                    textStyle: TextStyles.textMedium.copyWith(
                      fontFamily: 'CoconPro',
                      color: const Color(ColorCode.lightGrey4),
                    ),
                  ),
                ],
              ),
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //player image with attempt number list
                    Container(
                      width: 160,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/first_player_image_large.png',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 80,
                            height: 15,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: const Color(0x24a3959f),
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  controller.gameAttemptNumbers, (index) {
                                if (index == 0) {
                                  return const GameAttemptItem(
                                      isSelected: true);
                                }
                                return const GameAttemptItem();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TODO this stack for timer text
                    Positioned(
                      bottom: 85,
                      child: ObxValue<RxString>((state) {
                        return Visibility(
                          visible: !controller.chooseGameDifficulty.value,
                          child: Stack(
                            children: [
                              CustomText(
                                '${controller.time.value}',
                                maxLines: 2,
                                textStyle: TextStyles.textXXXLarge.copyWith(
                                  fontSize: 115,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              CustomText(
                                '${controller.time.value}',
                                maxLines: 2,
                                textStyle: TextStyles.textXXXLarge.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 115,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = const Color(ColorCode.black),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                              .animate(
                                  onPlay: (controller) =>
                                      controller.repeat(reverse: false))
                              .fade(
                                  curve: Curves.easeOut,
                                  begin: 0,
                                  end: 1,
                                  delay: 800.ms,
                                  duration: 1500.ms),
                        );
                      }, controller.time),
                    ),
                    //TODO this stack for player number text
                    Positioned(
                      left: 230,
                      bottom: 16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              CustomText(
                                "1",
                                maxLines: 1,
                                textStyle: TextStyles.textXXXLarge.copyWith(
                                  color: const Color(ColorCode.pink5),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Helvetica',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              CustomText(
                                '1',
                                maxLines: 1,
                                textStyle: TextStyles.textXXXLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Helvetica',
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = const Color(ColorCode.black),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomText(
                'Select difficulty',
                textStyle: TextStyles.textLarge.copyWith(
                  color: const Color(ColorCode.lightGrey4),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 350,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 50,
                        width: 500,
                        padding: const EdgeInsets.only(left: 20),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.973, 0.0),
                            end: Alignment(1.0, 0.0),
                            colors: [
                              Color(ColorCode.primaryBackground),
                              Color(ColorCode.black3),
                              Color(ColorCode.primaryBackground),
                            ],
                            stops: [0.0, 0.325, 1.0],
                          ),
                        ),
                        child: CustomText(
                          selectedGameAttributes
                                  ?.game?.data?.attributes?.name ??
                              "",
                          textAlign: TextAlign.start,
                          textStyle: TextStyles.textLarge.copyWith(
                            color: const Color(ColorCode.lightGrey4),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 500,
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.darkGrayBackground),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          width: 3.0,
                          color: const Color(ColorCode.grey),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(ColorCode.shadowBackground),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Container(
                        child:
                            selectedGameAttributes?.image?.data?.attributes !=
                                    null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(23.0),
                                    child: Image.network(
                                      selectedGameAttributes!.image!.data!
                                          .attributes!.formats!.thumbnail!.url!,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: Color(ColorCode.grey),
                                  ),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: 500,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0),
                          colors: [
                            Color(ColorCode.black4),
                            Color(ColorCode.shadowColor2)
                          ],
                          stops: [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    Positioned(
                      bottom: 65,
                      left: 70,
                      child: Container(
                        width: 300,
                        child: Stack(
                          children: [
                            CustomText(
                              selectedGameAttributes?.name?.toUpperCase() ?? "",
                              maxLines: 2,
                              textStyle: TextStyles.textLarge.copyWith(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                height: 1.0666666666666667,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.8
                                  ..color = Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              selectedGameAttributes?.name?.toUpperCase() ?? "",
                              maxLines: 2,
                              textStyle: TextStyles.textLarge.copyWith(
                                fontFamily: 'Roboto',
                                color: const Color(ColorCode.white)
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                height: 1.0666666666666667,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 220,
                      child: selectedGameAttributes!
                              .gameDifficulties!.data!.isNotEmpty
                          ? Container(
                              height: 130,
                              child: ListView.builder(
                                itemCount: selectedGameAttributes
                                    .gameDifficulties!.data!.length,
                                shrinkWrap: true,
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.chooseGameDifficulty.value =
                                          true;
                                      controller.setSelectedGameDifficulty(
                                          selectedGameAttributes
                                              .gameDifficulties!
                                              .data![index]
                                              .attributes!
                                              .difficulty);
                                      Get.rootDelegate
                                          .toNamed(Routes.START_GAME);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: GameDifficultyItem(
                                          imageSize: 110,
                                          imageUrl: selectedGameAttributes
                                                      .gameDifficulties!
                                                      .data![index]
                                                      .attributes
                                                      ?.difficulty ==
                                                  1
                                              ? 'assets/images/game_easy_large.png'
                                              : selectedGameAttributes
                                                          .gameDifficulties!
                                                          .data![index]
                                                          .attributes
                                                          ?.difficulty ==
                                                      2
                                                  ? 'assets/images/game_medium_large.png'
                                                  : 'assets/images/game_difficult_large.png',
                                          difficultyName: selectedGameAttributes
                                                  .gameDifficulties!
                                                  .data![index]
                                                  .attributes
                                                  ?.name ??
                                              ""),
                                    )  .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: false))
                                        .fade(
                                        curve: Curves.easeOut,
                                        begin: 0.7,
                                        end: 2,
                                        delay: 500.ms,
                                        duration: 1000.ms),
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 50,
                      width: 250,
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
                        borderRadius: BorderRadius.circular(56.0),
                        border: Border.all(
                            width: 4.0, color: const Color(ColorCode.aqua)),
                      ),
                      child: CustomText(
                        'Skip to next player',
                        textStyle: TextStyles.textMedium.copyWith(
                          fontFamily: 'CoconPro',
                          color: const Color(ColorCode.lightGrey6),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    width: 45,
                  ),
                ],
              )
              // Container(
              //   height: 90,
              //   margin: const EdgeInsets.symmetric(horizontal: 50),
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     gradient: const LinearGradient(
              //       begin: Alignment(-1.0, 0.0),
              //       end: Alignment(1.0, 0.0),
              //       colors: [Color(ColorCode.white3), Color(ColorCode.black2)],
              //       stops: [0.0, 1.0],
              //     ),
              //     borderRadius: BorderRadius.circular(56.0),
              //     border: Border.all(
              //         width: 6.0, color: const Color(ColorCode.aqua)),
              //   ),
              //   child: GestureDetector(
              //     onTap: () =>
              //         Get.rootDelegate.toNamed(Routes.GROUP_SELECT_GAME),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         CustomText(
              //           'Let\'s Play ',
              //           textStyle: TextStyles.textMedium.copyWith(
              //             fontFamily: 'CoconPro',
              //             color: const Color(ColorCode.aqua),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 20,
              //         ),
              //         Image.asset(
              //           'assets/images/lets_play_arrow.png',
              //           width: 40,
              //           height: 25,
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
