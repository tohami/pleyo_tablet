import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_button.dart';
import 'package:pleyo_tablet_app/widgets/custom_button_container.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/device_info.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import 'package:pleyo_tablet_app/pages/scan_qr/presentation/controllers/scan_qr_controller.dart';

// ignore: must_be_immutable
class ScanQRView extends GetView<TicketController> {
  ScanQRView({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final decoration = ShapeDecoration(
  color: const Color(ColorCode.black),
  shape: RoundedRectangleBorder(
  side: const BorderSide(width: 3, color: Color(ColorCode.white5Background)),
  borderRadius: BorderRadius.circular(16),
    ),
  );
  final isInfoSowing = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(ColorCode.black2Background),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObxValue<RxString>((state) {
              return Container(
                margin: const EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    state.value,
                    style: const TextStyle(
                      fontFamily: 'CoconPro',
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(ColorCode.lightGrey),
                      height: 0,
                    ),
                    softWrap: false,
                  ),
                ),
              );
            }, controller.errorMsg),
            const SizedBox(
              height: 17,
            ),
            ObxValue<RxString>((state) {
              final currentCodeParts = state.value.split("-");

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 42),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 100,
                        // width: 293,
                        // margin: const EdgeInsets.all(4),
                        decoration: decoration,
                        alignment: Alignment.center,
                        child: Text(
                          (currentCodeParts.length > 0
                                  ? currentCodeParts[0]
                                  : "")
                              .padRight(4, ' -'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                          softWrap: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Flexible(
                      flex: 1,
                      child: Container(
                        // margin: const EdgeInsets.all(4),
                        height: 100,
                        // width: 293,
                        decoration: decoration,
                        alignment: Alignment.center,
                        child: Text(
                          (currentCodeParts.length > 1
                                  ? currentCodeParts[1]
                                  : "")
                              .padRight(4, ' -'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, controller.inputCode),
            const SizedBox(
              height: 17,
            ),
            ObxValue<RxBool>((context) {
              return Expanded(
                child: !controller.isQrScan.value
                    ? Container(
                        // Keyboard is transparent
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ["7", "8", "9"],
                            ["4", "5", "6"],
                            ["1", "2", "3"],
                            ["Q", "0", "X"]
                          ]
                              .map((e) => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: e.map((e) {
                                      if (e.isEmpty) {
                                        return Container(
                                          width: 150,
                                        );
                                      }
                                      return numPadItem(e);
                                    }).toList(),
                                  ))
                              .toList(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 370,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: controller.onQRViewCreated,
                            ),
                          ),
                          numPadItem("Q"),
                        ],
                      ),
              );
            }, controller.isQrScan),
            numPadItem("H"),
            DeviceInfo()
          ],
        ),
      )),
    );
  }

  Widget numPadItem(String number) {
    var isClicked = false.obs;
    var text = controller.inputCode;
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: ObxValue((context) {
        return GestureDetector(
          onPanDown: (d) => isClicked.value = true,
          // onTapUp: (d) => isClicked.value = false,
          onPanEnd: (d) => isClicked.value = false,
          onTapDown: (d) {
            isClicked.value = false;
            if (number == "Q") {
              controller.isQrScan.value = !controller.isQrScan.value;
            } else if (number == "X") {
              text.value = text.substring(
                  0, text.value.length - (text.value.length == 5 ? 2 : 1));
            } else if (number == "H") {
              Get.rootDelegate.popRoute();
            } else {
              if (text.value.length == 9) {
                return;
              }
              if (text.value.length == 4) {
                text.value += "-";
              }
              text.value += number;
              if (text.value.length == 9) {
                controller.checkTicketWithPinCode(text.value);
              }
            }
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 140,
            height: 120,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-1.00, 0.00),
                end: Alignment(1, 0),
                colors: [
                  Color(ColorCode.primaryBackground),
                  Color(ColorCode.grey6)
                ],
              ),
              shape: RoundedRectangleBorder(
                side:  BorderSide(width: 3, color:  isClicked.value ?const Color(ColorCode.aqua) : const Color(ColorCode.blackBackground)),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            child: Center(
              child: (number == "X")
                  ? const Icon(
                      Icons.backspace_outlined,
                      size: 88,
                       color: const Color(ColorCode.aqua),
                    )
                  : (number == "Q")
                      ? Icon(
                          controller.isQrScan.value
                              ? Icons.numbers
                              : Icons.qr_code,
                          size: 88,
                          color: const Color(ColorCode.aqua),
                        )
                      : (number == "H")
                          ? const Icon(
                              Icons.home,
                              size: 88,
                              color: Color(ColorCode.aqua),
                            )
                          : Text(
                              number,
                              style: const TextStyle(
                                color: Color(ColorCode.white5Background),
                                fontSize: 100,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                              softWrap: false,
                            ),
            ),
          ),
        );
      }, isClicked),
    );
  }

  void showLoginWithPinCodeDialog(
      BuildContext context, TicketController controller) {
    var text = controller.inputCode;

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
