import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../model/game_model.dart';

class HomeController extends SuperController<bool> {
  Rx<QrCodeModel> qrCodeModel = Rx<QrCodeModel>(Get.rootDelegate.arguments());

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isChampion = true.obs;

  final RxList<GameModel> games = RxList<GameModel>([]);

  TextEditingController playerNameController = TextEditingController();

  HomeController();

  String username = "";

  DatabaseReference gamesRef = FirebaseDatabase.instance.ref("Game");
  DatabaseReference qrCodeRef = FirebaseDatabase.instance.ref("QRCode");

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    try {
      var gamesEntity = await gamesRef.get();
      games.addAll(gamesEntity.children.map((e) {
        return GameModel.fromJson(e.value as Map<dynamic, dynamic>);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // ignore: avoid_print
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    // ignore: avoid_print
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    // ignore: avoid_print
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // ignore: avoid_print
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    // ignore: avoid_print
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    // ignore: avoid_print
    print('onDetached called');
  }

  @override
  void onInactive() {
    // ignore: avoid_print
    print('onInative called');
  }

  @override
  void onPaused() {
    // ignore: avoid_print
    print('onPaused called');
  }

  @override
  void onResumed() {
    // ignore: avoid_print
    print('onResumed called');
  }

  @override
  void dispose() {
    playerNameController.dispose();
    super.dispose();
  }

  void changeMode(bool val) {
    isChampion.value = val;
  }

  void onLogoutClicked() {
    if (isLogoutActive.value) {
      //logout the player
      Get.rootDelegate.offNamed(Routes.SPLASH);
    } else {
      isLogoutActive.value = true;
    }
  }

  void onAddPlayerClicked() {
    if (isAddPlayerActive.value) {
      //logout the player

    } else {
      isAddPlayerActive.value = true;
    }
  }

  void addPlayer(String val) async{
    var qrCode = qrCodeModel.value;
    var players = qrCode.players ?? [];
    if (players.contains(val)) {
      players.remove(val);
      players.add(val);
    }
    qrCodeModel.value = qrCode;
    print("add player") ;

    try {
      await qrCodeRef.child("${qrCode.publicHashTag!}/players").push().set({
        val
      });
      // print(res)
    }catch (e) {
      print(e) ;
    }
  }
}
