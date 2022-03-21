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
import 'package:pleyo_tablet_app/widgets/predefined_amont_widget.dart';
import 'package:pleyo_tablet_app/widgets/qr_widget.dart';
import 'package:pleyo_tablet_app/widgets/steper_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget.dart';
import 'package:pleyo_tablet_app/widgets/ticket_widget_container.dart';

import '../controllers/custom_trial_ticket_controller.dart';

// ignore: must_be_immutable
class CustomTrialTicketView extends GetView<CustomTrialTicketController> {
  const CustomTrialTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          elevation: 1,
          automaticallyImplyLeading: false,
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
                isGenerateActive: true,
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 445,
                  ),
                  Container(
                    width: 471,
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          '${controller.isTrial ? "TRIAL" : "CUSTOM"} TICKET',
                          textStyle: TextStyles.textLarge
                              .copyWith(fontSize: 40, height: 1.25),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        CustomText(
                          'Add your custom amount of points',
                          textStyle: TextStyles.textLarge.copyWith(
                            fontSize: 24,
                            height: 1,
                            color: const Color(
                              ColorCode.lightBlackBackground,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: CustomTextFormField(
                                keyboardType: TextInputType.number,
                                hint: controller.isTrial ? '0' : '0.0',
                                hasBorder: true,
                                obscureText: false,
                                controller: controller.amountController,
                                suffix: Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: CustomText(
                                    controller.isTrial ? 'Pts' : '€',
                                    textStyle: TextStyles.textMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            CustomText(
                              '=',
                              textStyle: TextStyles.textLarge
                                  .copyWith(fontSize: 24, height: 1),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: const Color(ColorCode.blackBackground),
                                border: Border.all(
                                  width: 1.0,
                                  color: const Color(
                                      ColorCode.customGrayBackground),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      '0',
                                      textStyle: TextStyles.textMedium.copyWith(
                                        color: const Color(ColorCode.primary),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  CustomText(
                                    controller.isTrial ? '€' : 'Pts',
                                    textStyle: TextStyles.textMedium.copyWith(
                                      color: const Color(ColorCode.primary),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 43,
                        ),
                        ObxValue<RxBool>((state) {
                          return Visibility(
                            visible: !controller.isValidAmount.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'Predefined amounts',
                                  textAlign: TextAlign.start,
                                  textStyle: TextStyles.textLarge.copyWith(
                                    fontSize: 20,
                                    height: 1.2,
                                    color: const Color(
                                      ColorCode.lightBlackBackground,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        PredefinedAmountWidget(
                                          controller.isTrial
                                              ? '50 Pts'
                                              : '50 €',
                                          onTap: () {
                                            controller.amountController.text =
                                                "50";
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: controller.isTrial,
                                          child: CustomText(
                                            'Party of 5 ',
                                            textStyle:
                                                TextStyles.textMedium.copyWith(
                                              fontSize: 18,
                                              height: 1.2222222222222223,
                                              color: const Color(ColorCode
                                                  .lightBlackBackground),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        PredefinedAmountWidget(
                                          controller.isTrial
                                              ? '100 Pts'
                                              : '100 €',
                                          onTap: () {
                                            controller.amountController.text =
                                                "100";
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: controller.isTrial,
                                          child: CustomText(
                                            'Party of 10 ',
                                            textStyle:
                                                TextStyles.textMedium.copyWith(
                                              fontSize: 18,
                                              height: 1.2222222222222223,
                                              color: const Color(ColorCode
                                                  .lightBlackBackground),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        PredefinedAmountWidget(
                                          controller.isTrial
                                              ? '150 Pts'
                                              : '500 €',
                                          onTap: () {
                                            controller.amountController.text =
                                                "500";
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Visibility(
                                          visible: controller.isTrial,
                                          child: CustomText(
                                            'Party of 15 ',
                                            textStyle:
                                                TextStyles.textMedium.copyWith(
                                              fontSize: 18,
                                              height: 1.2222222222222223,
                                              color: const Color(ColorCode
                                                  .lightBlackBackground),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }, controller.isValidAmount),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 210,
                  ),
                  ObxValue<RxBool>((state) {
                    return QRWidget(
                      points: '30',
                      qrCode: controller.isValidAmount.value ? '0#EerT78/' : "",
                    );
                  }, controller.isValidAmount),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              controller.obx((state) {
                return CustomButtonContainer(
                    CustomButton(
                      CustomText(
                        'Continue',
                        textStyle: TextStyles.textMedium.copyWith(
                          color: const Color(ColorCode.primary),
                        ),
                      ),
                      () {
                        if (controller.isValidAmount.value) {
                          controller.onContinueClicked();
                        }
                      },
                      backGroundColor: controller.isValidAmount.value
                          ? Colors.black
                          : const Color(0x4d000000),
                      key: const ValueKey("loginBtn"),
                      borderRadius: 2,
                    ),
                    width: 327,
                    height: 48);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
