import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(ColorCode.grayBackground),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
