import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/controllers/home_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class GameDifficultyWidget extends StatelessWidget {
  final String title;
  final int color;
  final VoidCallback onTap;
  final RxBool isSelected = false.obs;

  GameDifficultyWidget(
      {Key? key, required this.title, required this.color, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return GestureDetector(
      onTap: () {
        if(controller.gameStatus.value == 0) {
          isSelected.value = true;
          onTap();
        }
      },
      child: Container(
          width: 480,
          height: 60,
          margin: const EdgeInsets.only(top: 25),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color(ColorCode.darkGrayBackground),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 3.0, color: Color(color)),
            boxShadow: const [
              BoxShadow(
                color: Color(ColorCode.blackBackground),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Obx(() {
            if (controller.gameStatus.value == 0) {
              isSelected.value = false;
            }
            return AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              switchInCurve: Curves.fastOutSlowIn,
              switchOutCurve: Curves.fastOutSlowIn,
              transitionBuilder: (child, animation) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: isSelected.value
                  ? Container(
                      key: ValueKey(isSelected.value),
                      color: Color(color),
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: CustomText(
                              "Cancel",
                              textStyle: TextStyles.textMedium.copyWith(
                                fontSize: 20,
                                color: Color(ColorCode.black2Background)
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              title,
                              textStyle: TextStyles.textMedium.copyWith(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/icon_arrow.svg',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
            );
          })),
    );
  }
}
