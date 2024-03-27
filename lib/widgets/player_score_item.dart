import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class PlayerScoreItem extends StatelessWidget {
  final String playerName;
  final String playerScore;
  final Gradient containerGradient;
  final Color imageBorderColor;
  final String imageUrl;

  const PlayerScoreItem(
      {Key? key,
      required this.playerName,
      required this.playerScore,
      required this.containerGradient,
      required this.imageBorderColor,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40, left: 70, right: 70),
      child: Stack(
        alignment: Alignment.centerLeft,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 50, right: 40),
            decoration: BoxDecoration(
              gradient: containerGradient,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Positioned(
            left: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(9999.0, 9999.0),
                ),
                border: Border.all(
                  width: 4.0,
                  color: imageBorderColor,
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: CachedNetworkImage(imageUrl:imageUrl)
              ),
            ),
          ),
          Positioned(
            left: 130,
            child: Container(
              width: 250,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomText(
                    playerName,
                    textStyle: TextStyles.textMedium.copyWith(
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.normal,
                      color: const Color(ColorCode.white4),
                    ),
                  ),
                  Expanded(child: Container()),
                  CustomText(
                    playerScore,
                    textStyle: TextStyles.textLarge.copyWith(
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w400,
                      color: const Color(ColorCode.white4),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
