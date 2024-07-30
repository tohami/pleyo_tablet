import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_host_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/multiplayer_guest_controller.dart';

class MultiplayerGuestGamePlay extends GetView<MultiplayerGuestController> {
  const MultiplayerGuestGamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        controller.stopGame("GamePlayingScreen:user click on hardware back button");
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(ColorCode.primaryBackground),
            title: const CustomText(
              'Quit',
              textStyle: TextStyles.textSmall,
              textAlign: TextAlign.start,
            ),
            titleSpacing: 5,
            leading: GestureDetector(
              onTap: () => controller.stopGame("GamePlayingScreen:user click on toolbar quite button"),
              child: const Icon(
                Icons.cancel_outlined,
                color: Color(ColorCode.darkGrey),
                size: 35,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  'Playing',
                  textStyle: TextStyles.textLarge.copyWith(
                    color: const Color(ColorCode.aqua),
                  ),
                ),

                SizedBox(height: 60,) ,
                CustomText(
                  '${controller.playerName}',
                  textStyle: TextStyles.textXXLarge.copyWith(
                    fontFamily: 'Helvetica Neue',
                    color: Colors.white,
                  ),
                ),

                Expanded(child: Container()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.stopGame("GamePlayingScreen:user click on quite button") ;
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.0, 0.055),
                            end: Alignment(0.699, 0.0),
                            colors: [
                              Color(ColorCode.black),
                              Color(ColorCode.primaryBackground)
                            ],
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(36.0),
                          border: Border.all(
                              width: 5.0, color: const Color(ColorCode.aqua)),
                        ),
                        child: CustomText(
                          'Quit',
                          textStyle: TextStyles.textXXLarge.copyWith(
                            color: const Color(ColorCode.lightGrey6),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
