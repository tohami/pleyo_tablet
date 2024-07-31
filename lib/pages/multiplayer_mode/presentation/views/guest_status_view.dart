import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_host_controller.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

import '../controllers/multiplayer_guest_controller.dart';

class MultiplayerGuestGameStatus extends GetView<MultiplayerGuestController> {
  const MultiplayerGuestGameStatus({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        controller.stopGame("GameStatusScreen:user click on back button");
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(ColorCode.primaryBackground),
            title: const CustomText(
              'Exit',
              textStyle: TextStyles.textSmall,
              textAlign: TextAlign.start,
            ),
            titleSpacing: 5,
            leading: GestureDetector(
              onTap: () => controller.stopGame("GamePlayingScreen:user click on toolbar quite button"),
              child: const Icon(
                Icons.arrow_back,
                color: Color(ColorCode.darkGrey),
                size: 35,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 60 ,bottom: 80),
            color: const Color(ColorCode.primaryBackground),
            child: Column(
              children: [
                CustomText(
                  'Go',
                  textStyle: TextStyles.textXXXLarge.copyWith(
                    fontSize: 100,
                    color: const Color(ColorCode.grey3),
                    // fontWeight: FontWeight.w700,
                  ),
                ),
                ObxValue<Rx>((game) {
                  var game = controller.multiplayerGame.value ;
                  return Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      fit: StackFit.loose,
                      children: [
                        Positioned(
                          top: 300,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                              child: Container(
                                height: 300,
                                width: 700,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(ColorCode.shadowColor3),
                                      offset: Offset(15, 15),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                                top: 300,
                                width: 500,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: game?.numberOfPlayers ?? 2,
                                      itemBuilder: (BuildContext context, int index) {
                                        var len = game?.scores?.length ?? 0 ;
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(ColorCode.black),
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 3.0, color: const Color(ColorCode.grey5)),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(ColorCode.shadowColor),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                '${index + 1}. ',
                                                textStyle: TextStyles.textXXLarge.copyWith(
                                                  fontFamily: 'Helvetica Neue',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              CustomText(
                                                index < len ? (game?.scores?[index].ticket?.nickname ?? "unknown") : ". . . .",
                                                textStyle: TextStyles.textXXLarge.copyWith(
                                                  fontFamily: 'Helvetica Neue',
                                                  color: Colors.white,
                                                ),
                    ),
                                              Spacer(
                                              ),
                                              index < len ? Icon(Icons.check_circle , color: Colors.green, size: 36,) : CircularProgressIndicator(
                                                color: Colors.yellow,
                                              )
                                            ],
                                          ),
                                        ) ;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 150,
                                    ),
                                    CustomText(
                                      'Waiting for host to start the game...',
                                      textStyle: TextStyles.textLarge.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                }, controller.multiplayerGame),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
