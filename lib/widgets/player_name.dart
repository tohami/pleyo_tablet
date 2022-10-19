import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';


Widget playerNameWidget({required String playerName, required void Function() onLogoutClicked}) {
  return Container(
    height: 60,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    child: Row(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:
            const Color(ColorCode.darkGrayBackground),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            border: Border.all(
                width: 3.0,
                color: const Color(
                    ColorCode.white2Background)),
          ),
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/icon_person.svg',
                fit: BoxFit.fitHeight,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 16,),
              SizedBox(
                width:70,
                child: CustomText(
                  playerName,
                  textAlign: TextAlign.start,
                  textStyle: TextStyles.textMedium.copyWith(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: onLogoutClicked,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border.all(
                width: 3.0,
                color:
                const Color(ColorCode.grayBackground),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x42000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
              color: const Color(ColorCode.grayBackground),
            ),
            child: SvgPicture.asset(
              'assets/images/icon_logout.svg',
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    ),
  ) ;
}