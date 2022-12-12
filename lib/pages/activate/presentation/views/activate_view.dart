import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';

import '../controllers/activate_controller.dart';

class ActivateView extends GetView<ActivateController> {
  const ActivateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(ColorCode.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 420,
                  height: 120,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width:300,
                        height: 100,
                        padding: EdgeInsets.only(left: 16),
                        child: Center(
                          child: CustomTextFormField(
                            controller: controller.nickNameController,
                            fontSize: 42,
                            fontColor: Colors.white,

                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12.5,
                      ),
                      SvgPicture.asset(
                        'assets/images/icon_add_person.svg',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 420,
                  child: GestureDetector(
                    onTap: () => controller.onStartClicked(),
                    onTapDown: (details) =>
                    controller.isButtonTapDown.value = true,
                    onTapCancel: () => controller.isButtonTapDown.value = false,
                    child: AnimatedBuilder(
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
                      child: Center(
                        child: CustomText(
                          'START',
                          textStyle: TextStyles.textXLarge.copyWith(
                            color: const Color(ColorCode.lightGrayBackground),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
