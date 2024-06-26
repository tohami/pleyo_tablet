import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game_message.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_field.dart';

import '../controllers/multiplayer_guest_controller.dart';

class GuestNameView extends StatelessWidget {
  JoinMultiplayerGameDetails details ;

  GuestNameView(this.details);

  @override
  Widget build(BuildContext context) {
    MultiplayerGuestController controller = Get.find();
    return ObxValue<RxBool>((goPlaying) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 45, left: 45, top: 50),
            height: 329,
            decoration: BoxDecoration(
              color: const Color(ColorCode.black),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('${details.host?.playerNickname} Invites you to play ${details.gameVariant} Multiplayer',
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.textMedium.copyWith(
                      fontFamily: 'CoconPro',
                      color: Color(
                        goPlaying.value ? ColorCode.aqua : ColorCode.lightGrey2,
                      ),
                    )),
                SizedBox(height: 5,) ,
                CustomText('Add your name and click go if you accept, click anywhere outside to decline ',
                    textAlign: TextAlign.start,
                    textStyle: TextStyles.textSmall.copyWith(
                      fontFamily: 'CoconPro',
                      color: Color(
                        goPlaying.value ? ColorCode.aqua : ColorCode.lightGrey2,
                      ),
                    )),
                SizedBox(height: 15,) ,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Type your Name',
                        controller: controller.playerNameController,
                        keyboardType: TextInputType.text,
                        onDoneClick: (text) =>
                            controller.onPlayerNameSelected(),
                        fontStyle: TextStyles.textSmall.copyWith(
                          fontFamily: 'CoconPro',
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 100,
                      child: CustomTextField(
                        hintText: '',
                        controller: controller.autoGeneratedNumberController,
                        keyboardType: TextInputType.text,
                        fontStyle: TextStyles.textSmall.copyWith(
                          fontFamily: 'CoconPro',
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        isEnabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  goPlaying.value
                      ? 'Up to 9 characters '
                      : 'Playerame will appear on the leaderboard, allowing you to follow your score.',
                  textStyle: TextStyles.textXSmall.copyWith(
                    color: const Color(ColorCode.lightGrey3),
                  ),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Positioned(
            top: 240,
            left: 270,
            child: ObxValue<RxBool>((state) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (goPlaying.value && !state.value)
                    controller.onPlayerNameSelected();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                            goPlaying.value
                                ? 'assets/images/go_button_active_bg.png'
                                : 'assets/images/go_button_inactive_bg.png',
                            height: 165,
                            width: 171)
                        .animate(target: state.value ? 1 : 0)
                        .scaleX(
                            duration: GetNumUtils(500).milliseconds,
                            begin: 1,
                            end: 0.8),
                    state.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : CustomText(
                            'Go',
                            textStyle: TextStyles.textXLarge.copyWith(
                              fontFamily: 'CoconPro',
                              color: Color(
                                goPlaying.value
                                    ? ColorCode.aqua
                                    : ColorCode.lightGrey2,
                              ),
                            ),
                          )
                  ],
                ),
              );
            }, controller.createTicketLoading),
          ),
        ],
      );
    }, controller.goPlaying);
  }
}
