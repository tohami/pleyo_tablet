import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';
import '../controllers/group_select_steps_controller.dart';

// ignore: must_be_immutable
class AddTeamNameStep extends GetView<GroupPlayStepsController> {
  const AddTeamNameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(ColorCode.primaryBackground),
          title: const CustomText(
            'Back to select the team',
            textStyle: TextStyles.textSmall,
            textAlign: TextAlign.start,
          ),
          titleSpacing: 5,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(ColorCode.darkGrey),
              size: 35,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          color: const Color(ColorCode.primaryBackground),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                'Give your team a winning name',
                textStyle: TextStyles.textMedium.copyWith(
                  color: const Color(ColorCode.lightGrey),
                  fontFamily: 'CoconPro',
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ObxValue<RxBool>((goPlaying) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.only(right: 45, left: 45, top: 50),
                      height: 229,
                      decoration: BoxDecoration(
                        color: const Color(ColorCode.black),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hintText: 'Enter Team Name here',
                            controller: controller.teamNameController,
                            keyboardType: TextInputType.text,
                            fontStyle: TextStyles.textSmall.copyWith(
                              fontFamily: 'CoconPro',
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            goPlaying.value
                                ? 'Max 20 characters '
                                : 'Make it memorable!',
                            textStyle: TextStyles.textXSmall.copyWith(
                              color: const Color(ColorCode.lightGrey3),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 220,
                      child: Image.asset('assets/images/group_play.png',
                          color: goPlaying.value
                              ? null
                              : const Color(ColorCode.grey),
                          height: 140,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 180,
                        left: 270,),

                      child: InkWell(
                        onTap: () {
                          print("go playnig") ;
                          if (goPlaying.value)
                            Get.rootDelegate.toNamed("${Routes.SELECT_TEAM_SIZE}/${Routes.GROUP_NAMES_LIST}");
                        },
                        child: Container(
                          width: 171,
                          height: 95,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  goPlaying.value
                                      ? 'assets/images/go_button_active_bg.png'
                                      : 'assets/images/go_button_inactive_bg.png',
                              ),
                            )
                          ),
                          child: Center(
                            child: CustomText(
                              'Go',
                              textStyle: TextStyles.textXLarge.copyWith(
                                fontFamily: 'CoconPro',
                                color: Color(
                                  goPlaying.value
                                      ? ColorCode.aqua
                                      : ColorCode.lightGrey2,
                                ),
                              ),
                            ),
                          ),
                ),
                        // child: Stack(
                        //   alignment: Alignment.center,
                        //   children: [
                        //     Image.asset(
                        //         goPlaying.value
                        //             ? 'assets/images/go_button_active_bg.png'
                        //             : 'assets/images/go_button_inactive_bg.png',
                        //         height: 165,
                        //         width: 171),
                        //     CustomText(
                        //       'Go',
                        //       textStyle: TextStyles.textXLarge.copyWith(
                        //         fontFamily: 'CoconPro',
                        //         color: Color(
                        //           goPlaying.value
                        //               ? ColorCode.aqua
                        //               : ColorCode.lightGrey2,
                        //         ),
                        //       ),
                        //     ).animate()
                        //   ],
                        // ),
                      ),
                    ),
                  ],
                );
              }, controller.goPlaying)
            ],
          ),
        ),
      ),
    );
  }
}
