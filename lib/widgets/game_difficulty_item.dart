import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class GameDifficultyItem extends StatelessWidget {
  final String imageUrl;
  final String difficultyName;

  const GameDifficultyItem(
      {Key? key, required this.imageUrl, required this.difficultyName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Image.asset(imageUrl, fit: BoxFit.fitHeight),
        ),
        CustomText(
          difficultyName,
          textStyle: TextStyles.textXSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
