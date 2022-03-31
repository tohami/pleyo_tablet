import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/machine_model.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/model/start_game_data.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../model/game_model.dart';

class HomeController extends SuperController<bool> {
  Rx<QrCodeModel> qrCodeModel = Rx<QrCodeModel>(Get.rootDelegate.arguments());

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isParty = true.obs;

  final RxList<GameModel> games = RxList<GameModel>([]);

  HomeController();

  String username = "";

  DatabaseReference gamesRef = FirebaseDatabase.instance.ref("Game");
  DatabaseReference machineRef = FirebaseDatabase.instance.ref("Machine");
  DatabaseReference qrCodesRef = FirebaseDatabase.instance.ref("QRCode");
  DatabaseReference messageQueueRef =
      FirebaseDatabase.instance.ref("MessageQueue");

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    try {
      var machineEntity = await machineRef.child(MACHINE_ID).get();
      var machine =
          MachineModel.fromJson(machineEntity.value as Map<dynamic, dynamic>);

      var gamesEntity = await gamesRef.get();
      games.addAll(gamesEntity.children.map((e) {
        var game = GameModel.fromJson(e.value as Map<dynamic, dynamic>);

        GameVariationList? machineVariation = machine.gameVariationList!
            .firstWhereOrNull((element) => element.idGame == game.idGame);

        if (machineVariation == null) {
          game.variationList?.clear();
        } else {
          List<String?> machineVariationIds =
          machineVariation.variationList!.map((e) => e.idVariation)
              .toList();
          //remove games thats not included in the machine
          game.variationList?.removeWhere((element) => !machineVariationIds.contains(element.idVariation));
        }

        return game;
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
    super.dispose();
  }

  void changeMode(bool val) {
    isParty.value = val;
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

  void addPlayer(String val) async {
    var qrCode = qrCodeModel.value;
    var players = qrCode.players ?? [];
    if (players.contains(val)) {
      players.remove(val);
      players.add(val);
    }
    qrCodeModel.value = qrCode;
    print("add player");

    try {
      await qrCodesRef
          .child("${qrCode.publicHashTag!}/players")
          .push()
          .set({val});
      // print(res)
    } catch (e) {
      print(e);
    }
  }

  //0 nothing
  //1 starting
  //2 started
  RxInt gameStatus = 0.obs ;

  void startGame(GameModel game, VariationList variant, String playerName,
      int diff) async {
    var now = DateTime.now();

    gameStatus.value = 1 ;

    //check available balance
    var currentQrCodeRef = qrCodesRef.child(qrCodeModel.value.publicHashTag!);
    try {
      var transactionResult = await currentQrCodeRef.runTransaction((value) {
        if(value == null) {
          return Transaction.abort();
        }

        var qrCode = QrCodeModel.fromJson(value as Map<dynamic, dynamic>) ;

        if(qrCode.isLocked == "true") {
          Get.snackbar("Error", "Your card currently used to run game on other machine, please try again");
          return Transaction.abort();
        }else if((qrCode.remainingCredit??0) < 10){
          Get.snackbar("Error", "You don't have enough points to run this game ");
          return Transaction.abort();
        }

        qrCode.remainingCredit = qrCode.remainingCredit! - 10 ;
        qrCode.isLocked = "true" ;

        return Transaction.success(
          qrCode.toJson()
        ) ;
      });

      if(!transactionResult.committed){
        return ;
      }
      // var currentPoints = codeRef.
      var startGameData = StartGameData(
          difficultyPlayed: diff.toString(),
          gameName: game.gameName,
          idGame: game.idGame,
          idMachine: MACHINE_ID,
          idVariation: variant.idVariation,
          isOnPartyMode: (isParty.value).toString(),
          partyName: playerName,
          playerNickName: playerName,
          publicHashtag: qrCodeModel.value.publicHashTag?.substring(
              qrCodeModel.value.publicHashTag!.length - 5),
          globalLeaderboardName: "${now.month}_${now.year}");

      var newCommand = messageQueueRef.push();

      newCommand
          .set({"CommandeId": "GAME_START", "Data": startGameData.toJson()});
      messageQueueRef.limitToFirst(1).onChildAdded.listen((event) {
        print("child added") ;
        print(event.snapshot.value) ;
      });
      gameStatus.value = 2 ;

      // throw Error() ;
    }catch (e){
      //return the credit if the game not started
      await currentQrCodeRef.update({
        "remainingCredit": ServerValue.increment(10),
      });
      gameStatus.value = 0 ;
    } finally {
      await currentQrCodeRef.update({
        "isLocked": "false",
      });
      await Future.delayed(Duration(seconds: 5)) ;
      // gameStatus.value = 0 ;
    }
    // Get.rootDelegate
    //     .toNamed(Routes.GAME_STATUS, parameters: {
    //   "game_mode":
    //   controller.isChampion.value.toString(),
    //   "points": controller
    //       .qrCodeModel.value.remainingCredit
    //       .toString(),
    //   "player_name": "Michel"
    // });
  }
}
