import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          elevation: 1,
          backgroundColor: const Color(ColorCode.darkGrayBackground),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icon_crown.svg',
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 2,
              ),
              CustomText(
                'Inscrivez le meilleur score pour gagner une récompense d\'une valeur de 200€',
                textStyle: TextStyles.textSmall.copyWith(
                  fontFamily: 'Parisine Plus Std Clair',
                  fontSize: 14,
                  color: const Color(ColorCode.white3Background),
                  height: 0.8571428571428571,
                ),
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
              border: Border.all(
                  width: 2.0,
                  color: const Color(ColorCode.lightGrayBackground)),
            ),
          ),
        ),
        body: Container(
          color: const Color(ColorCode.primary),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 213,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 60,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(ColorCode.darkGrayBackground),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            border: Border.all(
                                width: 3.0,
                                color: const Color(ColorCode.accentLightColor)),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_coins.svg',
                                fit: BoxFit.cover,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              CustomText(
                                '285',
                                textStyle: TextStyles.textMedium.copyWith(
                                  fontSize: 20,
                                  shadows: [
                                    const Shadow(
                                      color:
                                          Color(ColorCode.textShadowBackground),
                                      offset: Offset(0, 3),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
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
                                color: const Color(ColorCode.accentLightColor)),
                            color: const Color(ColorCode.accentLightColor),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/icon_logout.svg',
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                  FlutterSwitch(
                    width: 147.0,
                    height: 60.0,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    value: true,
                    borderRadius: 30.0,
                    showOnOff: false,
                    padding: 5,
                    activeColor: const Color(ColorCode.yellowBackground),
                    inactiveColor: const Color(ColorCode.accentLightColor),
                    activeSwitchBorder: Border.all(
                      width: 2.0,
                      color: const Color(ColorCode.darkYellowBackground),
                    ),
                    inactiveSwitchBorder: Border.all(
                      width: 2.0,
                      color: const Color(ColorCode.customAccentBackground),
                    ),
                    activeIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.darkGrayBackground),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: const [
                          BoxShadow(
                            color: const Color(0x42000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/icon_awesome_trophy.svg',
                          fit: BoxFit.contain,
                          width: 20,
                          height: 17.78,
                        ),
                      ),
                    ),
                    inactiveIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.darkGrayBackground),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: const [
                          BoxShadow(
                            color: const Color(0x42000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/icon_cake.svg',
                          fit: BoxFit.contain,
                          width: 16.25,
                          height: 20,
                        ),
                      ),
                    ),
                    onToggle: (val) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 213,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.darkGrayBackground),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        border: Border.all(
                            width: 3.0,
                            color: const Color(ColorCode.white2Background)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon_person.svg',
                            fit: BoxFit.fitHeight,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          CustomText(
                            'Kévin',
                            textStyle: TextStyles.textMedium.copyWith(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
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
                          color: const Color(ColorCode.grayBackground),
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
                        'assets/images/icon_add.svg',
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
