import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/start_game.dart';

import '../main.dart';
import '../model/strapi/station.dart';
import '../model/strapi/ticket.dart';
import 'package:socket_io_client/socket_io_client.dart' ;

class StationService extends GetxService {
  static StationService get to => Get.find();

  late Ticket currentTicket ;
  late Station currentStation ;
  final Rx<GameStatus> gameStatus = GameStatus(GameStatusType.IDLE, {}).obs;
  @override
  void onInit() {
    super.onInit();
    Socket socket = io(
        BASE_URL,
        OptionBuilder()
            .setAuth({"station": STATION_ID})
            .setTransports(
            ['websocket']) // for Flutter or Dart VM
            .build());

    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('StartGame', (data) => print(data));

    socket.onAny((event, args) {
      // if(event == "MessageQueue" && args.CommandeId == "GAME_START"){
      //   Future.delayed(Duration(seconds: 120)).then((value) => {
      //     if(gameStatus.value.type != GameStatusType.STARTED)
      //   })
      // }
      print("new event -----------") ;
      print(event);
      print(args) ;
      print("---------------------") ;

    });
    // socket.on('startGame',
    //         (data) => gameStatus.value = gameStatus.value = GameStatus(GameStatusType.STARTING, data));
    socket.on('gameStarted',
            (data) => gameStatus.value = GameStatus(GameStatusType.STARTED, data));
    socket.on('gameFinished',
            (data) => gameStatus.value = GameStatus(GameStatusType.FINISHED, data));
    socket.on('gameClosed',
            (data) => gameStatus.value = GameStatus(GameStatusType.CLOSED, data));
    socket.on('gameCrashed',
            (data) => gameStatus.value = GameStatus(GameStatusType.CRASHED, data));

    socket.onConnectError((data) => print("onConnectError")) ;
    socket.onConnectTimeout((data) => print("onConnectTimeout"+data)) ;
    socket.onConnecting((data) => print("onConnecting"+data)) ;
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }
}