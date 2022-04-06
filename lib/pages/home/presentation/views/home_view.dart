import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/game_model.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:pleyo_tablet_app/widgets/custom_text_form_field.dart';
import 'package:pleyo_tablet_app/widgets/game_widget.dart';
import 'package:pleyo_tablet_app/widgets/start_game_bottom_sheet.dart';
import 'package:pleyo_tablet_app/widgets/video_widget.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          elevation: 1,
          backgroundColor: const Color(ColorCode.darkGrayBackground),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icon_crown.svg',
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 2,
              ),
              CustomText(
                'Inscrivez le meilleur score pour gagner une récompense d\'une valeur de 200€',
                textStyle: TextStyles.textSmall.copyWith(
                  fontFamily: 'Parisine Plus Std Clair',
                  fontSize: 14,
                  color: const Color(ColorCode.white3Background),
                  height: 0.8571428571428571,
                ),
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
              border: Border.all(
                  width: 2.0,
                  color: const Color(ColorCode.lightGrayBackground)),
            ),
          ),
        ),
        body: SingleChildScrollView(
         physics: const ClampingScrollPhysics(),
          child: Container(
            color: const Color(ColorCode.primary),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        playerPointsWidget(),
                        const SizedBox(
                          height: 15,
                        ),
                        playerNameWidget(),
                      ],
                    ),
                    gameModeWidget(),
                  ],
                ),
                Obx(() {
                  // isChampion must be called any where to force rebuild
                  controller.isChampoinship.value;

                  if(controller.games.isNotEmpty) {
                    return ListView.builder(
                      itemCount: controller.games.length,
                      shrinkWrap: true,
                      clipBehavior: Clip.none ,
                      physics: const NeverScrollableScrollPhysics() ,
                      itemBuilder: (context , index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // key: ValueKey("${}"),
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            GameWidget(game: controller.games[index],isChampion: controller.isChampoinship.value,onPlayClicked: (variant) {
                              print(variant.toJson()) ;
                              showBottomSheetModal(context , variant , (diff , name) {
                                controller.startGame(
                                    controller.games[index] , variant ,name, diff
                                );
                              }) ;
                            },) ,

                          ],
                        ) ;
                      },
                    ) ;
                  }else {
                    return Container() ;
                  }

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }


  showBottomSheetModal(BuildContext context , VariationList variation,Function(int , String) onDifficultSelected) {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StartGameBottomSheet(
              controller: controller,
              gameVariation: variation,
              onDifficultSelected: onDifficultSelected,
            ),
          ],
        ) ,
        backgroundColor: const Color(ColorCode.darkGrayBackground),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        isScrollControlled: true) ;
  }

  Widget playerPointsWidget() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Obx(() {
        var isLogout = controller.isLogoutActive.value ;
        var isChampion = controller.isChampoinship.value ;
        var points = controller.qrCodeModel.value.remainingCredit.toString() ;
        return Row(
          children: [
            GestureDetector(
              onTap: ()=>controller.isLogoutActive.toggle(),
              child:  Container(
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:
                  const Color(ColorCode.darkGrayBackground),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  border: Border.all(
                      width: 3.0,
                      color: isChampion
                          ? const Color(
                          ColorCode.accentLightColor)
                          : const Color(
                          ColorCode.yellowBackground)),
                ),
                child:  AnimatedSize(
                  duration: const Duration(milliseconds:250),
                  child: Row(
                    key: ValueKey(isLogout),
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_coins.svg',
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 16,),
                      Container(
                        width: isLogout ? 210 :70,
                        child: CustomText(
                          isLogout ? 'Voulez-vous quitter ?' : points,
                          textAlign: TextAlign.start,
                          textStyle: TextStyles.textMedium.copyWith(
                            fontSize: 20,
                            shadows: [
                              const Shadow(
                                color: Color(
                                    ColorCode.textShadowBackground),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.onLogoutClicked(),
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  border: Border.all(
                      width: 3.0,
                      color: isChampion
                          ? const Color(
                          ColorCode.accentLightColor)
                          : const Color(
                          ColorCode.yellowBackground)),
                  color: isChampion
                      ? const Color(
                      ColorCode.accentLightColor)
                      : const Color(
                      ColorCode.yellowBackground),
                ),
                child: SvgPicture.asset(
                  'assets/images/icon_logout.svg',
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ) ;
      }),
    ) ;
  }

  Widget playerNameWidget() {
   return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Obx(() {
            var isAddPlayerActive = controller.isAddPlayerActive.value ;
            var players = controller.qrCodeModel.value.players??[] ;
            return Container(
              height: 60,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color:
                const Color(ColorCode.darkGrayBackground),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                border: Border.all(
                    width: 3.0,
                    color: const Color(
                        ColorCode.white2Background)),
              ),
              child:  GestureDetector(
                onTap: isAddPlayerActive ? null : ()=> controller.isAddPlayerActive.toggle(),
                child: AnimatedSize(
                  duration: const Duration(milliseconds:250),
                  child: Row(
                    key: ValueKey(isAddPlayerActive),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_person.svg',
                        fit: BoxFit.fitHeight,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 16,),
                      isAddPlayerActive ? SizedBox(
                        width: 210 ,
                        child: CustomTextFormField(
                          fontSize:20,
                          onSubmit: (val) {
                            // playerName.value = val;
                            print("on submit") ;
                            controller.addPlayer(val) ;
                          },
                          fontColor: const Color(
                              ColorCode.whiteBackground),
                        ),
                      ) : SizedBox(
                        width:70,
                        child: CustomText(
                          players.isNotEmpty ? players.last : "Add ...",
                          textAlign: TextAlign.start,
                          textStyle: TextStyles.textMedium.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ) ;
          }),
          GestureDetector(
            onTap: ()=> controller.isAddPlayerActive.toggle(),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                border: Border.all(
                  width: 3.0,
                  color:
                  const Color(ColorCode.grayBackground),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x42000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
                color: const Color(ColorCode.grayBackground),
              ),
              child: SvgPicture.asset(
                'assets/images/icon_add.svg',
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    ) ;
  }

  Widget gameModeWidget() {
    return ObxValue<RxBool>((state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlutterSwitch(
            width: 147.0,
            height: 60.0,
            disabled: true,
            valueFontSize: 25.0,
            toggleSize: 45.0,
            value: state.value,
            borderRadius: 30.0,
            showOnOff: false,
            padding: 5,
            activeColor:
            const Color(ColorCode.yellowBackground),
            inactiveColor:
            const Color(ColorCode.accentLightColor),
            activeSwitchBorder: Border.all(
              width: 2.0,
              color:
              const Color(ColorCode.darkYellowBackground),
            ),
            inactiveSwitchBorder: Border.all(
              width: 2.0,
              color:
              const Color(ColorCode.customAccentBackground),
            ),
            activeIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                const Color(ColorCode.darkGrayBackground),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(ColorCode.shadowBackground),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icon_awesome_trophy.svg',
                  fit: BoxFit.contain,
                  width: 20,
                  height: 17.78,
                ),
              ),
            ),
            inactiveIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color:
                const Color(ColorCode.darkGrayBackground),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(ColorCode.shadowBackground),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icon_cake.svg',
                  fit: BoxFit.contain,
                  width: 16.25,
                  height: 20,
                ),
              ),
            ),
            toggleColor: Colors.transparent,
            onToggle: (val) {
              controller.changeMode(val);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            state.value ? 'Championnat' : 'Party',
            textStyle: TextStyles.textMedium.copyWith(
              fontFamily: 'Parisine Plus Std Clair',
              color: const Color(ColorCode.white3Background),
            ),
          )
        ],
      );
    }, controller.isChampoinship) ;
  }
}
