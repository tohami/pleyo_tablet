import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class TicketWidgetContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color backGroundColor;
  final Color textColor;
  final Widget ticketWidget;
  final String ticketPrice;
  final String points;
  final VoidCallback? onPressed;

  const TicketWidgetContainer(this.onPressed, this.ticketWidget,
      {this.width = 250,
      this.height = 460,
      this.backGroundColor = const Color(ColorCode.lightGrayBackground),
      this.textColor = const Color(ColorCode.blackBackground),
      required this.ticketPrice,
      required this.points,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backGroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ticketWidget,
            const SizedBox(
              height: 10,
            ),
            CustomText(
              '=',
              textStyle:
                  TextStyles.textLarge.copyWith(color: textColor, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              '$points points',
              textStyle: TextStyles.textMedium
                  .copyWith(color: textColor, fontSize: 14),
            ),
            const SizedBox(
              height: 49,
            ),
            CustomText(
              'Allows you to generate a card worth $ticketPrice € for the Pleyo trampoline',
              textStyle: TextStyles.textMedium.copyWith(
                  height: 1.7142857142857142, color: textColor, fontSize: 14),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
