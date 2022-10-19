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
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/scan_qr_controller.dart';

// ignore: must_be_immutable
class ActivateTicketView extends GetView<ScanQRController> {
  ActivateTicketView({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(ColorCode.primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomText(
                'Enter your nickname to activate your ticket',
                textStyle: TextStyles.textLarge.copyWith(
                  fontFamily: 'Parisine Plus Std Clair',
                  color: Color(ColorCode.white2Background),
                  height: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 420,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width:400 ,
                          child: CustomTextFormField(
                            fontSize:48,
                            onSubmit: (val) {
                              // playerName.value = val;
                              controller.activateTicket(val) ;
                            },
                            onChange: (val) {
                              controller.username = val ;
                            },
                            fontColor: const Color(
                                ColorCode.whiteBackground),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => controller.activateTicket(controller.username),
                  child:Container(
                    width: 420,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(ColorCode.darkGrayBackground),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          width: 3.0,
                          color: const Color(ColorCode.accentLightColor).withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(ColorCode.shadowBackground).withOpacity(0.5),
                          offset: const Offset(0, 4),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomText(
                        'START',
                        textStyle: TextStyles.textXLarge.copyWith(
                          color: const Color(ColorCode.lightGrayBackground),
                        ),
                      ),
                    ),
                  )
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
