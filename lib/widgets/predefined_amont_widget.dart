import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class PredefinedAmountWidget extends StatelessWidget {
  final String ticketPrice;
  final VoidCallback onTap;

  const PredefinedAmountWidget(this.ticketPrice,
      {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(ColorCode.grayBackground),
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 2.0,
            color: const Color(ColorCode.customGrayBackground),
          ),
        ),
        child: CustomText(
          ticketPrice,
          textStyle: TextStyles.textMedium.copyWith(
            color: const Color(ColorCode.lightBlackBackground),
          ),
        ),
      ),
    );
  }
}
