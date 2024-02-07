import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';

class PlayerNameItem extends StatelessWidget {
  final Gradient containerGradient;
  final Color imageBorderColor;
  final Color nameColor;
  final String imageUrl;
  final int playerNumber;
  final String name;
  final bool isItemSelected;
  final bool hasSelectedItem;
  final TextEditingController controller;

  const PlayerNameItem(
      {Key? key,
      required this.containerGradient,
      required this.imageBorderColor,
      required this.nameColor,
      required this.imageUrl,
      required this.playerNumber,
      required this.name,
      required this.isItemSelected,
      required this.hasSelectedItem,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isItemSelected
        ? Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: Stack(
              alignment: Alignment.centerLeft,
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 60, right: 40),
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(ColorCode.primaryBackground),
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(width: 1.5, color: const Color(0xffffffff)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(ColorCode.shadowColor),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        width: 65,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 33,
                        child: CustomText(
                          "$playerNumber.",
                          textStyle: TextStyles.textXLarge.copyWith(
                            fontFamily: 'Helvetica Neue',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: controller,
                            autofocus: true,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            style: TextStyles.textXLarge.copyWith(
                              fontFamily: 'Helvetica Neue',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            cursorColor: Colors.white,
                            cursorWidth: 2.5,
                            decoration: InputDecoration(
                                hintText: 'Enter Name',
                                hintStyle: TextStyles.textMedium.copyWith(
                                  fontFamily: 'Helvetica Neue',
                                  color: const Color(ColorCode.grey2),
                                  fontWeight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0),
                      ),
                      border: Border.all(
                        width: 4.0,
                        color: imageBorderColor,
                      ),
                    ),
                    child: Image.asset(imageUrl),
                  ),
                ),
              ],
            ),
          )
        : hasSelectedItem
            ? Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 45,
                      margin: const EdgeInsets.only(left: 120, right: 100),
                      decoration: BoxDecoration(
                        gradient: containerGradient,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(9999.0, 9999.0),
                          ),
                          border: Border.all(
                            width: 4.0,
                            color: imageBorderColor,
                          ),
                        ),
                        child: Image.asset(imageUrl),
                      ),
                    ),
                    Positioned(
                      left: 200,
                      child: Row(
                        children: [
                          CustomText(
                            "$playerNumber.",
                            textStyle: TextStyles.textMedium.copyWith(
                              fontFamily: 'Helvetica Neue',
                              fontWeight: FontWeight.normal,
                              color: nameColor,
                            ),
                          ),
                          CustomText(
                            name,
                            textStyle: TextStyles.textMedium.copyWith(
                              fontFamily: 'Helvetica Neue',
                              fontWeight: FontWeight.normal,
                              color: nameColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 55,
                      margin: const EdgeInsets.only(left: 50, right: 40),
                      decoration: BoxDecoration(
                        gradient: containerGradient,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(9999.0, 9999.0),
                          ),
                          border: Border.all(
                            width: 4.0,
                            color: imageBorderColor,
                          ),
                        ),
                        child: Image.asset(imageUrl),
                      ),
                    ),
                    Positioned(
                      left: 160,
                      child: Row(
                        children: [
                          CustomText(
                            "$playerNumber.",
                            textStyle: TextStyles.textXLarge.copyWith(
                              fontFamily: 'Helvetica Neue',
                              fontWeight: FontWeight.normal,
                              color: nameColor,
                            ),
                          ),
                          CustomText(
                            name,
                            textStyle: TextStyles.textXLarge.copyWith(
                              fontFamily: 'Helvetica Neue',
                              fontWeight: FontWeight.normal,
                              color: nameColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}
