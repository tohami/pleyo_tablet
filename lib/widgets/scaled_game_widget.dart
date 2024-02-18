import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/game_difficulty.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_item.dart';

class ScaledGameWidget extends StatelessWidget {
  final List<GameDifficulty>? gameDifficultiesList;

  final String gameImageUrl;

  final String gameName;
  final VoidCallback onExitClicked;
  final Function(int selectedDifficulty) onSelectDifficulty;

  const ScaledGameWidget({
    Key? key,
    this.gameDifficultiesList,
    required this.gameImageUrl,
    required this.gameName,
    required this.onExitClicked,
    required this.onSelectDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
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
                    child: gameImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(23.0),
                            child: Image.network(
                              gameImageUrl,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 280,
                        height: 80,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            CustomText(
                              gameName.toUpperCase() ?? "",
                              maxLines: 2,
                              textStyle: TextStyles.textMedium.copyWith(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.8
                                  ..color = Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            CustomText(
                              gameName.toUpperCase() ?? "",
                              maxLines: 2,
                              textStyle: TextStyles.textMedium.copyWith(
                                fontFamily: 'Roboto',
                                color: const Color(ColorCode.lightGrey2),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      CustomText(
                        'Select difficulty',
                        textStyle: TextStyles.textXSmall.copyWith(
                            fontFamily: 'CoconPro',
                            color: const Color(ColorCode.white6),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onExitClicked,
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Color(ColorCode.darkGrey),
                      size: 55,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 185),
                  child: gameDifficultiesList!.isNotEmpty
                      ? Container(
                          height: 130,
                          child: ListView.builder(
                            itemCount: gameDifficultiesList!.length,
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  onSelectDifficulty(gameDifficultiesList![index].id!);
                                  // Get.rootDelegate.toNamed(Routes.START_GAME);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: GameDifficultyItem(
                                      imageSize: 110,
                                      imageUrl: gameDifficultiesList![index]
                                                  .attributes
                                                  ?.difficulty ==
                                              1
                                          ? 'assets/images/game_easy_large.png'
                                          : gameDifficultiesList![index]
                                                      .attributes
                                                      ?.difficulty ==
                                                  2
                                              ? 'assets/images/game_medium_large.png'
                                              : 'assets/images/game_difficult_large.png',
                                      difficultyName:
                                          gameDifficultiesList![index]
                                                  .attributes
                                                  ?.name ??
                                              ""),
                                ),
                                // .animate(
                                //     onPlay: (controller) =>
                                //         controller.repeat(reverse: false))
                                // .fade(
                                //     curve: Curves.easeIn,
                                //     begin: 0.5,
                                //     end: 1,
                                //     delay: 100.ms,
                                //     duration: 500.ms)
                                // .then()
                                // .fade(
                                //     curve: Curves.easeIn,
                                //     begin: 1,
                                //     end: 0.5,
                                //     duration: 500.ms),
                              );
                            },
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
