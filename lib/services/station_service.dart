import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/start_game.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game_message.dart';
import 'package:pleyo_tablet_app/model/strapi/organization.dart';
import 'package:pleyo_tablet_app/model/strapi/personas.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/join_game_controller.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_guest_controller.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../main.dart';
import '../model/strapi/station.dart';
import '../model/strapi/ticket.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../pages/multiplayer_mode/presentation/views/guest_name_dialog.dart';
import '../pages/splash/data/splash_repository.dart';

class StationService extends GetxService {
  static StationService get to => Get.find();

  late Ticket currentTicket;

  late Station currentStation;

  late Organization organization;

  late List<PersonaGroupData> personasGroups;

  RxBool isReady = false.obs;

  final Rx<GameStatus> gameStatus = GameStatus(GameStatusType.IDLE, {}).obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _initialize() {
    Socket socket = io(
        BASE_URL,
        OptionBuilder()
            .setAuth({"station": currentStation.id.toString()}).setTransports(
                ['websocket']) // for Flutter or Dart VM
            .build());

    socket.onConnect((_) {
      debugPrint('connect');
      socket.emit('msg', 'test');
    });
    socket.on('StartGame', (data) => debugPrint(data));

    socket.onAny((event, args) {
      if (event == "MessageQueue" && args["CommandeId"] == "GAME_START") {
        gameStatus.value = GameStatus(GameStatusType.STARTING, args);
      }
      debugPrint("new event -----------");
      debugPrint(event);
      debugPrint(args.toString());
      debugPrint("---------------------");
    });
    // socket.on('startGame',
    //         (data) => gameStatus.value = gameStatus.value = GameStatus(GameStatusType.STARTING, data));
    socket.on('JOIN_MULTIPLAYER_GAME', (data) {
      if (currentStation.attributes?.multiplayerEnabled == true) {
        JoinMultiplayerGameDetails details =
            JoinMultiplayerGameDetails.fromJson(data);
        JoinGameController controller = Get.find();
        controller.gameDetails = details;
        Get.dialog(
            Dialog(
              child: GuestNameView(details),
              backgroundColor: Colors.transparent,
            ),
            barrierColor: Colors.transparent,
            barrierDismissible: false);
      }
    });

    socket.on('UPDATE_MULTIPLAYER_GAME', (data) {
      gameStatus.value = GameStatus(GameStatusType.UPDATED, data);
    });

    socket.on('gameStarted',
        (data) => gameStatus.value = GameStatus(GameStatusType.STARTED, data));
    socket.on('gameResumed',
        (data) => gameStatus.value = GameStatus(GameStatusType.RESUMED, data));
    socket.on('gamePaused',
        (data) => gameStatus.value = GameStatus(GameStatusType.PAUSED, data));
    socket.on('gameFinished',
        (data) => gameStatus.value = GameStatus(GameStatusType.FINISHED, data));
    socket.on('gameClosed',
        (data) => gameStatus.value = GameStatus(GameStatusType.CLOSED, data));
    socket.on('gameCrashed',
        (data) => gameStatus.value = GameStatus(GameStatusType.CRASHED, data));

    socket.onConnectError((data) => debugPrint("onConnectError"));
    socket.onConnectTimeout((data) => debugPrint("onConnectTimeout" + data));
    socket.onConnecting((data) => debugPrint("onConnecting" + data));
    socket.onDisconnect((_) => debugPrint('disconnect'));
    socket.on('fromServer', (_) => debugPrint(_));
  }

  _init() async {
    var identifier = kIsWeb ? Uri.base.host : await UniqueIdentifier.serial;

    while (true) {
      try {
        var station =
            await Get.find<ISplashRepository>().findOrCreateStation(identifier);
        var personas = await Get.find<ISplashRepository>().getPersonas();

        if (station.attributes?.organization?.data != null) {
          currentStation = station;
          organization = station.attributes!.organization!.data!;
          personasGroups = personas;
          // FirebaseCrashlytics.instance.setUserIdentifier("${currentStation.attributes?.name}:${currentStation.id.toString()}") ;

          _initialize();
          isReady.value = true;
          break;
        }
      } on Error catch (e, stack) {
        // showAlert("Error", "Unable to load station data") ;
        print(e);
        print(stack);
        // FirebaseCrashlytics.instance.log("Get station Error") ;
        // FirebaseCrashlytics.instance.recordError(
        //     e,
        //     stack,
        //     reason: 'a fatal error',
        //     // Pass in 'fatal' argument
        //     fatal: true
        // );
        debugPrint(e.toString());
      } finally {
        await Future.delayed(const Duration(seconds: 15));
      }
    }
  }
}
