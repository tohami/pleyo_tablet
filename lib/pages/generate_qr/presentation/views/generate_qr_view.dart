import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/qr_widget.dart';
import 'package:pleyo_tablet_app/widgets/steper_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget_container.dart';

import '../controllers/generate_qr_controller.dart';

// ignore: must_be_immutable
class GenerateQRView extends GetView<GenerateQRController> {
  const GenerateQRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 1,
          leading: Container(),
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
              ObxValue<RxBool>((state) {
                return StepperWidget(
                  isGenerateActive:
                      !controller.isPrintStep.value ? true : false,
                  isPrintingActive: controller.isPrintStep.value ? true : false,
                );
              }, controller.isEmailClicked),
              const SizedBox(
                height: 81,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ObxValue<RxBool>((state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QRWidget(
                            points: '30',
                            qrCode: controller.isEmailClicked.value ||
                                    controller.isPrintClicked.value
                                ? '0#EerT78/'
                                : "",
                          ),
                          const SizedBox(
                            width: 64,
                          )
                        ],
                      );
                    }, controller.isEmailClicked),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 136,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              'Overview',
                              textStyle: TextStyles.textLarge
                                  .copyWith(fontSize: 40, height: 1.25),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomText(
                              '5 € ticket\n\n',
                              textStyle: TextStyles.textLarge.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.normal),
                            ),
                            CustomText(
                              '= \n\n',
                              textStyle: TextStyles.textLarge.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.normal),
                            ),
                            CustomText(
                              '30 points',
                              textStyle:
                                  TextStyles.textLarge.copyWith(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 117,
                            ),
                            ObxValue<RxBool>((state) {
                              return Row(
                                children: [
                                  CustomButtonContainer(
                                      CustomButton(
                                        CustomText(
                                          'EMAIL',
                                          textStyle:
                                              TextStyles.textXSmall.copyWith(
                                            color:
                                                const Color(ColorCode.primary),
                                          ),
                                        ),
                                        () {
                                          controller.isEmailClicked.value =
                                              true;
                                          controller.isPrintClicked.value =
                                              false;
                                          controller.isValidEmail.value = false;
                                          controller.emailController.text = '';
                                          controller.isPrintStep.value = false;
                                        },
                                        //0x4d000000
                                        backGroundColor:
                                            controller.isPrintClicked.value
                                                ? const Color(0x4d000000)
                                                : const Color(
                                                    ColorCode.blackBackground),
                                        key: const ValueKey("emailBtn"),
                                        borderRadius: 4,
                                      ),
                                      width: 200,
                                      height: 48),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  CustomButtonContainer(
                                      CustomButton(
                                        CustomText(
                                          'PRINT',
                                          textStyle:
                                              TextStyles.textXSmall.copyWith(
                                            color:
                                                const Color(ColorCode.primary),
                                          ),
                                        ),
                                        () {
                                          controller.isEmailClicked.value =
                                              false;
                                          controller.isPrintClicked.value =
                                              true;
                                          controller.isValidEmail.value = false;
                                          controller.emailController.text = '';
                                          controller.isPrintStep.value = true;
                                        },
                                        backGroundColor:
                                            controller.isEmailClicked.value
                                                ? const Color(0x4d000000)
                                                : const Color(
                                                    ColorCode.blackBackground),
                                        key: const ValueKey("printBtn"),
                                        borderRadius: 4,
                                      ),
                                      width: 200,
                                      height: 48),
                                ],
                              );
                            }, controller.isEmailClicked),
                            const SizedBox(
                              height: 50,
                            ),
                            ObxValue<RxBool>((state) {
                              return Visibility(
                                visible: controller.isEmailClicked.value &&
                                    !controller.isValidEmail.value,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 360,
                                      height: 50,
                                      child: CustomTextFormField(
                                        hint: 'Typing',
                                        hasBorder: true,
                                        obscureText: false,
                                        controller: controller.emailController,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    CustomButtonContainer(
                                        CustomButton(
                                          CustomText(
                                            'Send By Email',
                                            textStyle:
                                                TextStyles.textXSmall.copyWith(
                                              color: const Color(
                                                  ColorCode.primary),
                                            ),
                                          ),
                                          () {
                                            controller.sendEmail();
                                          },
                                          backGroundColor: const Color(
                                              ColorCode.blackBackground),
                                          key: const ValueKey("emailBtn"),
                                          borderRadius: 4,
                                        ),
                                        width: 200,
                                        height: 48)
                                  ],
                                ),
                              );
                            }, controller.isEmailClicked),
                            ObxValue<RxBool>((state) {
                              return Visibility(
                                visible: controller.isPrintClicked.value,
                                child: Container(
                                  width: 453,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(ColorCode.primary),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(
                                            ColorCode.customGrayBackground)),
                                  ),
                                  child: const CustomText(
                                    'The ticket should print within a few seconds, please wait',
                                    textStyle: TextStyles.textMedium,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              );
                            }, controller.isPrintClicked),
                            ObxValue<RxBool>((state) {
                              return Visibility(
                                visible: controller.isValidEmail.value,
                                child: Container(
                                  width: 453,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(ColorCode.primary),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                        width: 2.0,
                                        color: const Color(
                                            ColorCode.customGrayBackground)),
                                  ),
                                  child: const CustomText(
                                    'The ticket has been sent, please wait',
                                    textStyle: TextStyles.textMedium,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              );
                            }, controller.isPrintClicked),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
