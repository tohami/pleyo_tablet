import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class GameDifficultyWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final int color;
  final VoidCallback onTap;

  const GameDifficultyWidget(
      {Key? key,
      this.isSelected = false,
      required this.title,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 480,
        height: 60,
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: const Color(ColorCode.darkGrayBackground),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 3.0, color: Color(color)),
          boxShadow: const [
            BoxShadow(
              color: Color(ColorCode.blackBackground),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                title,
                textStyle: TextStyles.textMedium.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SvgPicture.asset(
              'assets/images/icon_arrow.svg',
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
