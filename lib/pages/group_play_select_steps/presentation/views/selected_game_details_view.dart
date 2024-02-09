import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/controllers/group_select_steps_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_item.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';

class SelectedGameDetails extends GetView<GroupPlayStepsController> {
  const SelectedGameDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGameAttributes = controller.selectedGame.value.attributes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Games',
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
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomText(
                'Your selected Game',
                textStyle: TextStyles.textMedium.copyWith(
                  fontFamily: 'CoconPro',
                  color: const Color(ColorCode.lightGrey6),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 84,
                    width: 350,
                    margin: EdgeInsets.only(top: 250),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60, top: 30),
                      child: CustomText(
                        selectedGameAttributes?.game?.data?.attributes?.name ??
                            "",
                        textStyle: TextStyles.textLarge.copyWith(
                          color: const Color(ColorCode.lightGrey4),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 280,
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
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          child:
                              selectedGameAttributes?.image?.data?.attributes !=
                                      null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(23.0),
                                      child: Image.network(
                                        selectedGameAttributes!
                                            .image!
                                            .data!
                                            .attributes!
                                            .formats!
                                            .thumbnail!
                                            .url!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Color(ColorCode.grey),
                                    ),
                        ),
                      ),
                      Container(
                        height: 280,
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
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 90,
                        child: selectedGameAttributes!
                                .gameDifficulties!.data!.isNotEmpty
                            ? Container(
                                height: 70,
                                child: ListView.builder(
                                  itemCount: selectedGameAttributes
                                      .gameDifficulties!.data!.length,
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GameDifficultyItem(
                                        imageUrl: selectedGameAttributes
                                                    .gameDifficulties!
                                                    .data![index]
                                                    .attributes
                                                    ?.difficulty ==
                                                1
                                            ? 'assets/images/game_easy.png'
                                            : selectedGameAttributes
                                                        .gameDifficulties!
                                                        .data![index]
                                                        .attributes
                                                        ?.difficulty ==
                                                    2
                                                ? 'assets/images/game_medium.png'
                                                : 'assets/images/game_diffcult.png',
                                        difficultyName: selectedGameAttributes
                                                .gameDifficulties!
                                                .data![index]
                                                .attributes
                                                ?.name ??
                                            "");
                                  },
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 280,
                padding: const EdgeInsets.only(top: 30, left: 60),
                child: Stack(
                  children: [
                    CustomText(
                      selectedGameAttributes.name?.toUpperCase() ?? "",
                      maxLines: 2,
                      textStyle: TextStyles.textXLarge.copyWith(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.8
                          ..color = Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      selectedGameAttributes.name?.toUpperCase() ?? "",
                      maxLines: 2,
                      textStyle: TextStyles.textXLarge.copyWith(
                        fontFamily: 'Roboto',
                        color: const Color(ColorCode.lightGrey2),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 50),
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
                child: GestureDetector(
                  onTap: () =>
                      Get.rootDelegate.toNamed(Routes.GROUP_SELECT_GAME),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        'Let\'s Play ',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
