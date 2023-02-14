import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../controllers/scan_qr_controller.dart';

// ignore: must_be_immutable
class ScanQRView extends GetView<TicketController> {
  ScanQRView({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // SizedBox(
            //   child: QRView(
            //     key: qrKey,
            //     onQRViewCreated: controller.onQRViewCreated,
            //   ),
            // ),
            AnimatedBuilder(
              animation: controller.boxAnimation,
              builder: (context, child) {
                return Transform.scale(
                    scale: controller.boxAnimation.value, child: child);
              },
              child: Stack(
                children: [
                  Container(
                    child: Opacity(
                      opacity: 0.9,
                      child: SvgPicture.asset(
                        'assets/images/scan_qr_bg.svg',
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 320,
                      height: 320,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 5.0,
                            color: const Color(ColorCode.accentLightColor)),
                      ),
                      child: ObxValue<RxBool>((state) {
                        return Visibility(
                          visible: state.value,
                          child: SvgPicture.asset(
                            'assets/images/icon_validation.svg',
                            fit: BoxFit.contain,
                            width: 140,
                            height: 104,
                          ),
                        );
                      }, controller.isScanned),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 80),
                      child: ObxValue<RxBool>((state) {
                        return CustomText(
                          state.value
                              ? 'QRcode is valid!'
                              : 'Scan your QRcode\nTo start playing',
                          textStyle: TextStyles.textLarge.copyWith(
                            fontFamily: 'Parisine Plus Std Clair',
                            color: Colors.black,
                            height: 1.1666666666666667,
                          ),
                        );
                      }, controller.isScanned)),
                  GestureDetector(
                    onTap: () =>
                        {showLoginWithPinCodeDialog(context, controller)},
                    child: Container(
                      width: 360,
                      height: 64,
                      margin: EdgeInsets.only(bottom: 80),
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.darkGrayBackground),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 3.0,
                            color: const Color(ColorCode.accentLightColor)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(ColorCode.shadowBackground),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomText(
                          'Enter pin code instead',
                          textStyle: TextStyles.textLarge.copyWith(
                            color: const Color(ColorCode.accentLightColor),
                            // height: 0.5833333333333334,
                            fontFamily: 'Parisine Plus Std Clair',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLoginWithPinCodeDialog(
      BuildContext context, TicketController controller) {
    RxString text = "".obs;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(ColorCode.primary),
            content: Container(
              width: 370,
              height: 460,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    'Enter your ticket pin code ',
                    textStyle: TextStyles.textLarge.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  ObxValue<RxString>(
                      (state) => CustomText(
                            state.value,
                            textStyle: TextStyles.textXLarge.copyWith(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10),
                          ),
                      text),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                    // Keyboard is transparent
                    // color: Colors.red,
                    child: VirtualKeyboard(
                        // [0-9] + .
                        type: VirtualKeyboardType.Numeric,
                        textColor: Colors.white,
                        fontSize: 24,
                        // Callback for key press event
                        onKeyPress: (key) {
                          if (key.keyType == VirtualKeyboardKeyType.String &&
                              key.text != ".") {
                            text.value = text.value + key.text;
                          } else if (key.keyType ==
                              VirtualKeyboardKeyType.Action) {
                            switch (key.action) {
                              case VirtualKeyboardKeyAction.Backspace:
                                if (text.value.length == 0) return;
                                text.value = text.value
                                    .substring(0, text.value.length - 1);
                                break;
                              case VirtualKeyboardKeyAction.Return:
                                text.value = text.value + '\n';
                                break;
                              case VirtualKeyboardKeyAction.Space:
                                text.value = text.value + key.text;
                                break;
                              default:
                            }
                          }
                        }),
                  )
                ],
              ),
            ),
            actions: [
              CustomButtonContainer(
                ObxValue<RxBool>((state) {
                  return state.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          CustomText(
                            'Start Playing',
                            textStyle: TextStyles.textMedium.copyWith(
                                color: const Color(ColorCode.accentLightColor),
                                fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          () {
                            controller.checkTicketWithPinCode(text.value);
                            // Navigator.of(context).pop();
                          },
                          backGroundColor:
                              const Color(ColorCode.darkGrayBackground),
                          borderRadius: 4,
                        );
                }, controller.isLoading),
                width: 300,
                height: 60,
                borderWidth: 2.0,
                borderColor: ColorCode.accentLightColor,
              ),
            ],
            actionsPadding: const EdgeInsets.only(bottom: 20),
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }
}
