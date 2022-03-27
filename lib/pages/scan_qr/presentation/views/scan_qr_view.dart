import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/scan_qr_controller.dart';

// ignore: must_be_immutable
class ScanQRView extends GetView<ScanQRController> {
  ScanQRView({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              child: QRView(
                key: qrKey,
                onQRViewCreated: controller.onQRViewCreated,
              ),
            ),
            AnimatedBuilder(
              animation: controller.boxAnimation,
              builder: (context, child) {
                return Transform.scale(
                    scale: controller.boxAnimation.value, child: child);
              },
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.9,
                    child: SvgPicture.asset(
                      'assets/images/scan_qr_bg.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 320,
                      height: 320,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 5.0,
                            color: const Color(ColorCode.accentLightColor)),
                      ),
                      child: ObxValue<RxString>((state) {
                        return Visibility(
                          visible: state.value.isNotEmpty,
                          child: SvgPicture.asset(
                            'assets/images/icon_validation.svg',
                            fit: BoxFit.contain,
                            width: 140,
                            height: 104,
                          ),
                        );
                      }, controller.qrCode),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: ObxValue<RxString>((state) {
                    return CustomText(
                      state.value.isNotEmpty
                          ? 'QRcode valide !'
                          : 'Scannez votre QRcode\npour commencer à jouer',
                      textStyle: TextStyles.textLarge.copyWith(
                        fontFamily: 'Parisine Plus Std Clair',
                        height: 1.1666666666666667,
                      ),
                    );
                  }, controller.qrCode)),
            ),
          ],
        ),
      ),
    );
  }
}
