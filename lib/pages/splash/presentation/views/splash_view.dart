import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'package:pleyo_tablet_app/pages/splash/presentation/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(ColorCode.primary),

          child: Stack(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: controller.buttonAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 420,
                            height: 420,
                            decoration: BoxDecoration(
                              color: const Color(ColorCode.darkGrayBackground),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  width: 3.0,
                                  color: const Color(ColorCode.accentLightColor)
                                      .withOpacity(
                                          controller.buttonAnimation.value)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(ColorCode.shadowBackground),
                                  offset: const Offset(0, 4),
                                  blurRadius:
                                      controller.isButtonTapDown.value ? 0 : 4,
                                ),
                              ],
                            ),
                            child: child,
                          );
                        },
                        child: const Center(
                         child : CircularProgressIndicator(color: Color(ColorCode.lightGrayBackground),)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FutureBuilder<String?>(future: UniqueIdentifier.serial , builder: (context , data) {
                  return Text(data.data??"...") ;
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
