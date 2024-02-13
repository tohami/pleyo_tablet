import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_text.dart';

class GameExperienceSelectItem extends StatelessWidget {
  final Color borderColor;
  final Color titleColor;
  final String selectItemAssetUrl;
  final String selectArrowAssetUrl;
  final String selectTitle;
  final String selectDetails;
  final VoidCallback onTap;

  const GameExperienceSelectItem({
    required this.borderColor,
    required this.titleColor,
    required this.selectItemAssetUrl,
    required this.selectArrowAssetUrl,
    required this.selectTitle,
    required this.selectDetails,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRect(
        child: Container(
          height: 140,
          padding: const EdgeInsets.only(left: 22.5, right: 22.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            border: Border.all(
              width: 4.0,
              color: borderColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, right: 20),
                child: Image.asset(
                  selectItemAssetUrl,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      selectTitle,
                      maxLines: 1,
                      textStyle:
                          TextStyles.textXLarge.copyWith(color: titleColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      selectDetails,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      textStyle: TextStyles.textXSmall
                          .copyWith(color: const Color(ColorCode.white)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  selectArrowAssetUrl,
                  width: 18,
                  height: 35,
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .moveX(begin: 1, end: 7, delay: 400.ms, duration: 700.ms)
                // runs after the above w/new duration
                ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
