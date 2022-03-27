import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/game_model.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
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
                //end of header
                const SizedBox(
                  height: 60,
                ),
                CustomText(
                  'Neon',
                  textStyle: TextStyles.textLarge.copyWith(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: Get.width,
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      VideoWidget(
                        GameModel(
                            id: "10",
                            name: "Heartbeat Spaces",
                            description: "Jeu de rythme • Arcade • Casual",
                            url:
                                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
                        onTap: () {
                          showBottomSheetModal(context);
                        },
                        key: const ValueKey(1),
                      ),
                      VideoWidget(
                        GameModel(
                            id: "10",
                            name: "Heartbeat Spaces",
                            description: "Jeu de rythme • Arcade • Casual",
                            url:
                                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
                        onTap: () {
                          showBottomSheetModal(context);
                        },
                        key: const ValueKey(2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomText(
                  'Space Invaders',
                  textStyle: TextStyles.textLarge.copyWith(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: Get.width,
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      VideoWidget(
                        GameModel(
                            id: "10",
                            name: "Heartbeat Spaces",
                            description: "Jeu de rythme • Arcade • Casual",
                            url:
                                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
                        onTap: () {
                          showBottomSheetModal(context);
                        },
                        key: const ValueKey(3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget partySwitch(RxBool isParty) {
    var championContainer = Container(
      key: const ValueKey(2),
      decoration: BoxDecoration(
        color: const Color(0xfffeff40),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(width: 2.0, color: const Color(0xffb2b22d)),
      ),
    );

    var partyContainer = Container(
      key: const ValueKey(1),
      decoration: BoxDecoration(
        color: const Color(0xff2ff7f7),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(width: 2.0, color: const Color(0xff21adad)),
      ),
    );

    var championIcon = Stack(
      children: [
        Center(
          child: SizedBox(
            width: 16.0,
            height: 20.0,
            child: SvgPicture.string(
              '<svg viewBox="98.8 10.0 16.4 20.0" ><path transform="translate(94.32, 10.0)" d="M 12.68181800842285 5.454545497894287 C 13.69090938568115 5.454545497894287 14.49999904632568 4.636363983154297 14.49999904632568 3.636363744735718 C 14.49999904632568 3.290909290313721 14.40909004211426 2.972727537155151 14.23636436462402 2.700000286102295 L 12.68181800842285 0 L 11.12727165222168 2.700000286102295 C 10.95454406738281 2.972727537155151 10.8636360168457 3.290909290313721 10.8636360168457 3.636363744735718 C 10.8636360168457 4.636363983154297 11.68181610107422 5.454545497894287 12.68181800842285 5.454545497894287 Z M 16.86363410949707 14.53636455535889 L 15.89090919494629 13.56363868713379 L 14.90909004211426 14.53636455535889 C 13.72727108001709 15.71818351745605 11.65454483032227 15.72727489471436 10.4636344909668 14.53636455535889 L 9.490908622741699 13.56363868713379 L 8.499999046325684 14.53636455535889 C 7.909091472625732 15.127272605896 7.118182182312012 15.45454692840576 6.281818389892578 15.45454692840576 C 5.618182182312012 15.45454692840576 5.009091377258301 15.24545574188232 4.5 14.89999961853027 L 4.5 19.09090995788574 C 4.5 19.59090995788574 4.909090995788574 20 5.409090995788574 20 L 19.95454406738281 20 C 20.45454788208008 20 20.8636360168457 19.59090995788574 20.8636360168457 19.09090995788574 L 20.8636360168457 14.89999961853027 C 20.35454559326172 15.24545478820801 19.74545669555664 15.45454692840576 19.08181762695312 15.45454692840576 C 18.24545478820801 15.45454692840576 17.45454597473145 15.127272605896 16.86363410949707 14.53636455535889 Z M 18.13636207580566 8.181818008422852 L 13.59090805053711 8.181818008422852 L 13.59090805053711 6.36363697052002 L 11.77272605895996 6.36363697052002 L 11.77272605895996 8.181818008422852 L 7.227272987365723 8.181818008422852 C 5.718182563781738 8.181818008422852 4.5 9.40000057220459 4.5 10.90909099578857 L 4.5 12.30909156799316 C 4.5 13.2909107208252 5.300000190734863 14.09090995788574 6.281818389892578 14.09090995788574 C 6.754546165466309 14.09090995788574 7.209091186523438 13.90909194946289 7.53636360168457 13.57272911071777 L 9.481818199157715 11.6363639831543 L 11.41818046569824 13.57272911071777 C 12.09090805053711 14.24545574188232 13.26363563537598 14.24545574188232 13.93636226654053 13.57272911071777 L 15.88181686401367 11.6363639831543 L 17.81818008422852 13.57272911071777 C 18.15454483032227 13.90909194946289 18.59999847412109 14.09090995788574 19.07272720336914 14.09090995788574 C 20.05454635620117 14.09090995788574 20.85454559326172 13.2909107208252 20.85454559326172 12.30909156799316 L 20.85454559326172 10.90909099578857 C 20.8636360168457 9.40000057220459 19.64545440673828 8.181818008422852 18.13636207580566 8.181818008422852 Z" fill="#ffffff" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 20.0,
            height: 18.0,
            child: SvgPicture.string(
              '<svg viewBox="97.0 11.1 20.0 17.8" ><path transform="translate(97.0, 11.11)" d="M 19.16666603088379 2.222222089767456 L 15.55555534362793 2.222222089767456 L 15.55555534362793 0.8333332538604736 C 15.55555534362793 0.371527761220932 15.18402767181396 0 14.72222232818604 0 L 5.277777671813965 0 C 4.815972328186035 0 4.44444465637207 0.371527761220932 4.44444465637207 0.8333332538604736 L 4.44444465637207 2.222222089767456 L 0.8333333134651184 2.222222089767456 C 0.3715277910232544 2.222222089767456 0 2.593749761581421 0 3.05555534362793 L 0 4.999999523162842 C 0 6.239583015441895 0.78125 7.513888359069824 2.149305582046509 8.496526718139648 C 3.243055582046509 9.284721374511719 4.572916984558105 9.784721374511719 5.96875 9.944443702697754 C 7.059027671813965 11.75347137451172 8.333333015441895 12.49999904632568 8.333333015441895 12.49999904632568 L 8.333333015441895 14.99999904632568 L 6.666666507720947 14.99999904632568 C 5.440972328186035 14.99999904632568 4.44444465637207 15.71874904632568 4.44444465637207 16.94444274902344 L 4.44444465637207 17.36110877990723 C 4.44444465637207 17.59027481079102 4.631944179534912 17.77777671813965 4.861111164093018 17.77777671813965 L 15.13888931274414 17.77777671813965 C 15.36805534362793 17.77777671813965 15.55555534362793 17.59027481079102 15.55555534362793 17.36110877990723 L 15.55555534362793 16.94444274902344 C 15.55555534362793 15.71874904632568 14.55902767181396 14.99999904632568 13.33333301544189 14.99999904632568 L 11.66666698455811 14.99999904632568 L 11.66666698455811 12.49999904632568 C 11.66666698455811 12.49999904632568 12.94097232818604 11.75347137451172 14.03125 9.944443702697754 C 15.43055534362793 9.784722328186035 16.76041603088379 9.284721374511719 17.85069465637207 8.496526718139648 C 19.21527862548828 7.513888835906982 20 6.239583015441895 20 4.999999523162842 L 20 3.05555534362793 C 20 2.593749761581421 19.62847328186035 2.222222089767456 19.16666603088379 2.222222089767456 Z M 3.447916746139526 6.694443702697754 C 2.600694417953491 6.083333015441895 2.222222328186035 5.402777671813965 2.222222328186035 4.999999523162842 L 2.222222328186035 4.444444179534912 L 4.451389312744141 4.444444179534912 C 4.486111164093018 5.576388359069824 4.652777671813965 6.569444179534912 4.895833492279053 7.4375 C 4.371527671813965 7.256944179534912 3.881944417953491 7.006944179534912 3.447916746139526 6.694444179534912 Z M 17.77777862548828 4.999999523162842 C 17.77777862548828 5.559027671813965 17.16319465637207 6.253471851348877 16.55208206176758 6.694443702697754 C 16.11805534362793 7.006943702697754 15.62499904632568 7.256944179534912 15.10069370269775 7.437499523162842 C 15.34375 6.569443702697754 15.51041603088379 5.576387882232666 15.54513835906982 4.444444179534912 L 17.77777862548828 4.444444179534912 L 17.77777862548828 4.999999523162842 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
            ),
          ),
        )
      ],
    );

    var partyIcon = Stack(
      children: [
        Center(
          child: SizedBox(
            width: 16.0,
            height: 20.0,
            child: SvgPicture.string(
              '<svg viewBox="11.8 10.0 16.4 20.0" ><path transform="translate(7.32, 10.0)" d="M 12.68181800842285 5.454545497894287 C 13.69090938568115 5.454545497894287 14.49999904632568 4.636363983154297 14.49999904632568 3.636363744735718 C 14.49999904632568 3.290909290313721 14.40909004211426 2.972727537155151 14.23636436462402 2.700000286102295 L 12.68181800842285 0 L 11.12727165222168 2.700000286102295 C 10.95454406738281 2.972727537155151 10.8636360168457 3.290909290313721 10.8636360168457 3.636363744735718 C 10.8636360168457 4.636363983154297 11.68181610107422 5.454545497894287 12.68181800842285 5.454545497894287 Z M 16.86363410949707 14.53636455535889 L 15.89090919494629 13.56363868713379 L 14.90909004211426 14.53636455535889 C 13.72727108001709 15.71818351745605 11.65454483032227 15.72727489471436 10.4636344909668 14.53636455535889 L 9.490908622741699 13.56363868713379 L 8.499999046325684 14.53636455535889 C 7.909091472625732 15.127272605896 7.118182182312012 15.45454692840576 6.281818389892578 15.45454692840576 C 5.618182182312012 15.45454692840576 5.009091377258301 15.24545574188232 4.5 14.89999961853027 L 4.5 19.09090995788574 C 4.5 19.59090995788574 4.909090995788574 20 5.409090995788574 20 L 19.95454406738281 20 C 20.45454788208008 20 20.8636360168457 19.59090995788574 20.8636360168457 19.09090995788574 L 20.8636360168457 14.89999961853027 C 20.35454559326172 15.24545478820801 19.74545669555664 15.45454692840576 19.08181762695312 15.45454692840576 C 18.24545478820801 15.45454692840576 17.45454597473145 15.127272605896 16.86363410949707 14.53636455535889 Z M 18.13636207580566 8.181818008422852 L 13.59090805053711 8.181818008422852 L 13.59090805053711 6.36363697052002 L 11.77272605895996 6.36363697052002 L 11.77272605895996 8.181818008422852 L 7.227272987365723 8.181818008422852 C 5.718182563781738 8.181818008422852 4.5 9.40000057220459 4.5 10.90909099578857 L 4.5 12.30909156799316 C 4.5 13.2909107208252 5.300000190734863 14.09090995788574 6.281818389892578 14.09090995788574 C 6.754546165466309 14.09090995788574 7.209091186523438 13.90909194946289 7.53636360168457 13.57272911071777 L 9.481818199157715 11.6363639831543 L 11.41818046569824 13.57272911071777 C 12.09090805053711 14.24545574188232 13.26363563537598 14.24545574188232 13.93636226654053 13.57272911071777 L 15.88181686401367 11.6363639831543 L 17.81818008422852 13.57272911071777 C 18.15454483032227 13.90909194946289 18.59999847412109 14.09090995788574 19.07272720336914 14.09090995788574 C 20.05454635620117 14.09090995788574 20.85454559326172 13.2909107208252 20.85454559326172 12.30909156799316 L 20.85454559326172 10.90909099578857 C 20.8636360168457 9.40000057220459 19.64545440673828 8.181818008422852 18.13636207580566 8.181818008422852 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 20.0,
            height: 18.0,
            child: SvgPicture.string(
              '<svg viewBox="10.0 11.1 20.0 17.8" ><path transform="translate(10.0, 11.11)" d="M 19.16666603088379 2.222222089767456 L 15.55555534362793 2.222222089767456 L 15.55555534362793 0.8333332538604736 C 15.55555534362793 0.371527761220932 15.18402767181396 0 14.72222232818604 0 L 5.277777671813965 0 C 4.815972328186035 0 4.44444465637207 0.371527761220932 4.44444465637207 0.8333332538604736 L 4.44444465637207 2.222222089767456 L 0.8333333134651184 2.222222089767456 C 0.3715277910232544 2.222222089767456 0 2.593749761581421 0 3.05555534362793 L 0 4.999999523162842 C 0 6.239583015441895 0.78125 7.513888359069824 2.149305582046509 8.496526718139648 C 3.243055582046509 9.284721374511719 4.572916984558105 9.784721374511719 5.96875 9.944443702697754 C 7.059027671813965 11.75347137451172 8.333333015441895 12.49999904632568 8.333333015441895 12.49999904632568 L 8.333333015441895 14.99999904632568 L 6.666666507720947 14.99999904632568 C 5.440972328186035 14.99999904632568 4.44444465637207 15.71874904632568 4.44444465637207 16.94444274902344 L 4.44444465637207 17.36110877990723 C 4.44444465637207 17.59027481079102 4.631944179534912 17.77777671813965 4.861111164093018 17.77777671813965 L 15.13888931274414 17.77777671813965 C 15.36805534362793 17.77777671813965 15.55555534362793 17.59027481079102 15.55555534362793 17.36110877990723 L 15.55555534362793 16.94444274902344 C 15.55555534362793 15.71874904632568 14.55902767181396 14.99999904632568 13.33333301544189 14.99999904632568 L 11.66666698455811 14.99999904632568 L 11.66666698455811 12.49999904632568 C 11.66666698455811 12.49999904632568 12.94097232818604 11.75347137451172 14.03125 9.944443702697754 C 15.43055534362793 9.784722328186035 16.76041603088379 9.284721374511719 17.85069465637207 8.496526718139648 C 19.21527862548828 7.513888835906982 20 6.239583015441895 20 4.999999523162842 L 20 3.05555534362793 C 20 2.593749761581421 19.62847328186035 2.222222089767456 19.16666603088379 2.222222089767456 Z M 3.447916746139526 6.694443702697754 C 2.600694417953491 6.083333015441895 2.222222328186035 5.402777671813965 2.222222328186035 4.999999523162842 L 2.222222328186035 4.444444179534912 L 4.451389312744141 4.444444179534912 C 4.486111164093018 5.576388359069824 4.652777671813965 6.569444179534912 4.895833492279053 7.4375 C 4.371527671813965 7.256944179534912 3.881944417953491 7.006944179534912 3.447916746139526 6.694444179534912 Z M 17.77777862548828 4.999999523162842 C 17.77777862548828 5.559027671813965 17.16319465637207 6.253471851348877 16.55208206176758 6.694443702697754 C 16.11805534362793 7.006943702697754 15.62499904632568 7.256944179534912 15.10069370269775 7.437499523162842 C 15.34375 6.569443702697754 15.51041603088379 5.576387882232666 15.54513835906982 4.444444179534912 L 17.77777862548828 4.444444179534912 L 17.77777862548828 4.999999523162842 Z" fill="#000000" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => isParty.toggle(),
      child: SizedBox(
        width: 147,
        height: 60,
        child: Stack(
          children: [
            ObxValue<RxBool>((state) {
              return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: state.value ? partyContainer : championContainer);
            }, isParty),
            ObxValue<RxBool>((state) {
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (widget, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: widget,
                  );
                },
                child: Stack(
                  key: ValueKey(state.value),
                  children: [
                    Positioned(
                      top: 10,
                      right: state.value ? null : 10,
                      left: state.value ? 10 : null,
                      bottom: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xff494949),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x42000000),
                              offset: Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: state.value ? partyIcon : championIcon,
                      ),
                    ),
                  ],
                ),
              );
            }, isParty),
          ],
        ),
      ),
    );
  }

  showBottomSheetModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color(ColorCode.darkGrayBackground),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        isScrollControlled: true,

        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StartGameBottomSheet(
                controller: controller,
              ),
            ],
          );
        });
  }

  Widget playerPointsWidget() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: ()=>controller.isLogoutActive.toggle(),
            child: ObxValue<RxBool>((state) {
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
                          ColorCode.accentLightColor)),
                ),
                child:  AnimatedSize(
                  duration: const Duration(milliseconds:250),
                  child: Row(
                    key: ValueKey(state.value),
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_coins.svg',
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 16,),
                      Container(
                        width: state.value ? 210 :70,
                        child: CustomText(
                          state.value ? 'Voulez-vous quitter ?' : '285',
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
              ) ;
            } , controller.isLogoutActive),
          ),
          Container(
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
                  color: const Color(
                      ColorCode.accentLightColor)),
              color:
              const Color(ColorCode.accentLightColor),
            ),
            child: SvgPicture.asset(
              'assets/images/icon_logout.svg',
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    ) ;
  }

  Widget playerNameWidget() {
    return Container(
      width: 213,
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 150,
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
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon_person.svg',
                  fit: BoxFit.fitHeight,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 16,
                ),
                CustomText(
                  'Kévin',
                  textStyle: TextStyles.textMedium.copyWith(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
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
          )
        ],
      ),
    );
  }

  Widget gameModeWidget() {
    return ObxValue<RxBool>((state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FlutterSwitch(
            width: 147.0,
            height: 60.0,
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
    }, controller.isParty) ;
  }
}
