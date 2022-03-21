import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class QRWidget extends StatelessWidget {
  final String points;
  final String qrCode;

  const QRWidget({this.qrCode = '', required this.points, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 45, right: 45, top: 10),
      width: 250,
      height: 460,
      decoration: BoxDecoration(
        color: const Color(ColorCode.lightGrayBackground),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(ColorCode.shadowBackground),
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(ColorCode.lightBlackBackground),
              borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
            ),
            child: CustomText(
              '30 points',
              textStyle: TextStyles.textXSmall.copyWith(
                color: const Color(ColorCode.whiteBackground),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            width: 160,
            height: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(ColorCode.whiteBackground),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 3.0,
                color: const Color(ColorCode.lightBlackBackground),
              ),
            ),
            child: Image.asset(
              'assets/images/qr_code.png',
              fit: BoxFit.cover,
              width: 130,
              height: 130,
            ),
          ),
          const SizedBox(
            height: 58,
          ),
          CustomText(
            'CODE',
            textStyle: TextStyles.textLarge.copyWith(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(ColorCode.whiteBackground),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                  width: 2.0,
                  color: const Color(ColorCode.lightBlackBackground)),
            ),
            // '0#EerT78/'
            child: qrCode.isNotEmpty ? CustomText(
              qrCode,
              textStyle: TextStyles.textSmall,
            ) : Container(),
          )
        ],
      ),
    );
  }
}
