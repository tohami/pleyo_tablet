import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/steper_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget_container.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 1,
          backgroundColor: const Color(ColorCode.primary),
          title: Container(
            margin: const EdgeInsets.only(top: 17.5, bottom: 17.5, left: 50),
            width: 216,
            height: 40,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.fill,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 14.5, bottom: 14.5, right: 25),
              child: CustomButtonContainer(
                  CustomButton(
                    CustomText(
                      'LOG OUT',
                      textStyle: TextStyles.textSmall.copyWith(
                        color: const Color(ColorCode.whiteBackground),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    () {},
                    backGroundColor: const Color(ColorCode.blackBackground),
                    borderRadius: 4,
                  ),
                  width: 148,
                  height: 48),
            )
          ],
        ),
        body: Container(
          color: const Color(ColorCode.whiteBackground),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
          child: Column(
            children: [
              Row(
                children: [
                  CustomButtonContainer(
                      CustomButton(
                        const Icon(Icons.home,
                            size: 16, color: Color(ColorCode.primary)),
                        () {},
                        backGroundColor:
                            const Color(ColorCode.lightBlackBackground),
                        borderRadius: 4,
                      ),
                      width: 50,
                      height: 48),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomButtonContainer(
                      CustomButton(
                        const Icon(Icons.arrow_back_outlined,
                            size: 16, color: Color(ColorCode.primary)),
                        () {},
                        backGroundColor:
                            const Color(ColorCode.lightBlackBackground),
                        borderRadius: 4,
                      ),
                      width: 50,
                      height: 48),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const StepperWidget(
                isChoiceActive: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.GENERATE_QR);
                    },
                    const TicketWidget('2 € ticket'),
                    points: '10',
                    ticketPrice: '2',
                  ),
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.GENERATE_QR);
                    },
                    const TicketWidget('5 € ticket'),
                    points: '30',
                    ticketPrice: '5',
                  ),
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.GENERATE_QR);
                    },
                    const TicketWidget('10 € ticket'),
                    points: '70',
                    ticketPrice: '10',
                  ),
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.GENERATE_QR);
                    },
                    const TicketWidget('15 € ticket'),
                    points: '120',
                    ticketPrice: '15',
                  ),
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.CUSTOM_TRIAL_TICKET,
                          parameters: {"is_trial": "0"});
                    },
                    const TicketWidget(
                      'CUSTOM',
                      backGroundColor: Color(ColorCode.customGrayBackground),
                      textColor: Color(ColorCode.blackBackground),
                    ),
                    points: '???',
                    ticketPrice: 'custom',
                    backGroundColor: Color(ColorCode.darkGrayBackground),
                    textColor: Color(ColorCode.primary),
                  ),
                  TicketWidgetContainer(
                    () {
                      Get.rootDelegate.toNamed(Routes.CUSTOM_TRIAL_TICKET,
                          parameters: {"is_trial": "1"});
                    },
                    const TicketWidget(
                      'TRIAL',
                      backGroundColor: Color(ColorCode.customGrayBackground),
                      textColor: Color(ColorCode.blackBackground),
                    ),
                    points: '???',
                    ticketPrice: 'trial',
                    backGroundColor: Color(ColorCode.darkGrayBackground),
                    textColor: Color(ColorCode.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
