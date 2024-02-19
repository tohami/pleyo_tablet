import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/game_difficulty_item.dart';

class GroupVideoWidget extends StatelessWidget {
  final GameVariant variantModel;
  final VoidCallback onTap;
  final RxBool isInitialized = false.obs;

  final Map<int, String> difficultyImagePaths = {
    1: 'assets/images/game_easy.png',
    2: 'assets/images/game_medium.png',
    3: 'assets/images/game_diffcult.png'
  };
  GroupVideoWidget(this.variantModel,
      {required this.onTap, Key? key})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    var gameDifficulties = variantModel.attributes?.gameDifficulties?.data;
    if (gameDifficulties != null) {
      gameDifficulties.sort((a, b) {
        // Assuming 'gamehubId' is a numeric type (int). If it's a string, you might need to use compareTo directly
        // without parsing them as integers.
        var idA = a.attributes?.gamehubId;
        var idB = b.attributes?.gamehubId;
        if(idA ==null || idB == null)
          return -1 ;

        return idA.compareTo(idB);
      });
    }
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 200,
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
            margin: const EdgeInsets.only(right: 20),
            child: Container(
              child: variantModel.attributes?.image?.data?.attributes != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(23.0),
                child: CachedNetworkImage(
                  imageUrl: variantModel.attributes?.image?.data?.attributes?.url??"",
                  fit: BoxFit.fill,
                ),
              )
                  : const CircularProgressIndicator(
                color: Color(ColorCode.customAccent2Background),
              ),
            ),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 30, left: 15),
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
            child: Stack(
              children: [
                CustomText(
                  variantModel.attributes?.name?.toUpperCase() ?? "",
                  maxLines: 2,
                  textStyle: TextStyles.textMedium.copyWith(
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
                  variantModel.attributes?.name?.toUpperCase() ?? "",
                  maxLines: 2,
                  textStyle: TextStyles.textMedium.copyWith(
                    fontFamily: 'Roboto',
                    color: const Color(ColorCode.lightGrey2),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 27,
            child: gameDifficulties!.isNotEmpty
                ? Container(
              height: 70,
              child: ListView.builder(
                itemCount: gameDifficulties.length,
                shrinkWrap: true,
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GameDifficultyItem(
                      imageUrl: difficultyImagePaths[gameDifficulties[index].attributes?.difficulty] ?? 'assets/images/game_difficult.png',
                      difficultyName: gameDifficulties[index].attributes?.name ?? "");
                },
              ),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}
