import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_slide_animation/number_slide_animation.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/activation_screen.dart';
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
                        width: 300,
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
            Builder(builder: (context) {
              var fields = controller
                  .ticket.attributes?.competition?.activationScreen?.fields;
              if (fields?.isNotEmpty == true) {
                return ObxValue<RxMap>((state) {
                  print(state.toString());
                  return Column(
                    children: fields!.map((field) {
                      switch (field.type) {
                        case "text":
                        case "number":
                          return Container(
                            width: 420,
                            height: 120,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: const Color(ColorCode.darkGrayBackground),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  width: 3.0,
                                  color:
                                      const Color(ColorCode.accentLightColor)),
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
                                  width: 350,
                                  height: 100,
                                  padding: EdgeInsets.only(left: 16),
                                  child: Center(
                                    child: CustomTextFormField(
                                      hint: field.title!,
                                      keyboardType: field.type == "text"
                                          ? TextInputType.text
                                          : TextInputType.number,
                                      initialValue: controller
                                          .activationFormValue[field.key!],
                                      onChanged: (value) {
                                        controller.activationFormValue[
                                            field.key!] = value ?? "";
                                      },
                                      fontSize: 30,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        case "color":
                          return Container(
                            width: 420,
                            margin: EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                CustomText(
                                  field.title!,
                                  textStyle: TextStyles.textLarge.copyWith(
                                    fontSize: 32,
                                    // height: 2.066666666666667,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: field.options!.map((e) {
                                    bool isSelected =
                                        state[field.key] == e.value;
                                    return GestureDetector(
                                      onTap: () => controller
                                              .activationFormValue[field.key!] =
                                          e.value!,
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        margin: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: e.value!
                                              .toColor()
                                              ?.withOpacity(
                                                  isSelected ? 1.0 : 0.5),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: isSelected
                                              ? Border.all(
                                                  width: 3.0,
                                                  color: const Color(ColorCode
                                                      .accentLightColor))
                                              : null,
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: e.value!.toColor(),
                                          //     offset: Offset(0, 4),
                                          //     blurRadius: 4,
                                          //   ),
                                          // ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          );
                        case "dropdown":
                          return Container(
                            width: 420,
                            height: 120,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: const Color(ColorCode.darkGrayBackground),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  width: 3.0,
                                  color:
                                      const Color(ColorCode.accentLightColor)),
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
                                  width: 350,
                                  height: 100,
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: controller.activationFormValue[field.key!],
                                      items: field.options!
                                          .map((e) => DropdownMenuItem<String>(
                                              value: e.value!,
                                              child: Container(
                                                padding: EdgeInsets.only(left: 16 ),
                                                child: CustomText(
                                                  e.text!,
                                                  textStyle: TextStyles.textLarge
                                                      .copyWith(
                                                    fontSize: 32,
                                                    // height: 2.066666666666667,
                                                  ),
                                                ),
                                              )))
                                          .toList(),
                                      onChanged: (i) => {
                                        controller.activationFormValue[field.key!] = i!
                                      },
                                      dropdownColor: Colors.black,
                                      isExpanded: true,
                                      itemHeight: 100,
                                    ),
                                    // child: CustomTextFormField(
                                    //   hint: field.title!,
                                    //   keyboardType: field.type == "text"
                                    //       ? TextInputType.text
                                    //       : TextInputType.number,
                                    //   initialValue: controller
                                    //       .activationFormValue[field.key!],
                                    //   onChanged: (value) {
                                    //     controller.activationFormValue[
                                    //     field.key!] = value ?? "";
                                    //   },
                                    //   fontSize: 30,
                                    //   fontColor: Colors.white,
                                    // ),
                                  ),
                                )
                              ],
                            ),
                          );
                      }
                      return Container();
                    }).toList(),
                  );
                }, controller.activationFormValue);
              }
              return Container();
            }),
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
