import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class TicketWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backGroundColor;
  final Color textColor;
  final String ticketPrice;

  const TicketWidget(this.ticketPrice,
      {this.width = 160,
      this.height = 160,
      this.backGroundColor = const Color(ColorCode.lightBlackBackground),
      this.textColor = const Color(ColorCode.primary),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
        color: backGroundColor,
      ),
      child: CustomText(
        ticketPrice,
        textStyle:
            TextStyles.textLarge.copyWith(fontSize: 24, color: textColor),
      ),
    );
  }
}
