import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../consts/colors.dart';
import '../consts/text_styles.dart';
import 'custom_text.dart';

class GroupNumberSelectItem extends StatelessWidget {
  final Color borderColor;
  final Color titleColor;
  final String selectArrowAssetUrl;
  final String selectNumber;
  final String turnsNumber;
  final String gameDuration;

  const GroupNumberSelectItem({
    required this.borderColor,
    required this.titleColor,
    required this.selectArrowAssetUrl,
    required this.selectNumber,
    required this.turnsNumber,
    required this.gameDuration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //40
      width: 100,
      height: 100,
      padding: const EdgeInsets.only(left: 30, right: 5,top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(width: 4.0, color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              CustomText(
                selectNumber,
                textStyle: TextStyles.textXXXLarge.copyWith(color: titleColor),
              ),
              const SizedBox(width: 35,),
              Image.asset(selectArrowAssetUrl,
                width:78,
                height: 58,
              ),
            ],
          ),
          CustomText(
            'Players',
            textStyle: TextStyles.textMedium.copyWith(
                fontWeight: FontWeight.normal,
                fontFamily: 'CoconPro',
                color: Colors.white),
          ),
          SizedBox(height: 20,),
          CustomText(
            '$turnsNumber turns each ',
            textStyle: TextStyles.textXSmall.copyWith(
              fontFamily: 'CoconPro',
              color: const Color(ColorCode.extraLightGrey),
              fontWeight: FontWeight.w300,
            ),
          ),
          CustomText(
            'Time : $gameDuration min ',
            textStyle: TextStyles.textXSmall.copyWith(
              fontFamily: 'CoconPro',
              color: const Color(ColorCode.extraLightGrey),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
