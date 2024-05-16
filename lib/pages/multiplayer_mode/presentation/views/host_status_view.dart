import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_host_controller.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class MultiplayerHostGameStatus extends GetView<MultiplayerHostController> {
  const MultiplayerHostGameStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedGameAttributes = controller.selectedVariant.value!.attributes!;
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
                ObxValue<RxBool>((gameFail) {
                  return CustomText(
                    'Go',
                    textStyle: TextStyles.textXXXLarge.copyWith(
                      fontSize: 100,
                      color: gameFail.value
                          ? const Color(ColorCode.lightGrey8)
                          : const Color(ColorCode.grey3),
                      // fontWeight: FontWeight.w700,
                    ),
                  );
                }, controller.gameFail),
                ObxValue<RxBool>((gameFail) {
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
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      selectedGameAttributes.image?.data?.attributes?.url??"",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.19),
                                        BlendMode.dstIn),
                                  ),
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
                        gameFail.value
                            ? Positioned(
                                top: 300,
                                child: InkWell(
                                  onTap: ()=>controller.startGame(controller.selectedDifficulty!),
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
                                          width: 5.0,
                                          color: const Color(0xff2ff7f7)),
                                    ),
                                    child: CustomText(
                                      'Retry',
                                      textStyle: TextStyles.textXXLarge.copyWith(
                                        color: const Color(ColorCode.lightGrey6),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Positioned(
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
                                      'Waiting for players to join',
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
                }, controller.gameFail),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
