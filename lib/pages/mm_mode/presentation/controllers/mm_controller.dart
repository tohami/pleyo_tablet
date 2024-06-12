import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/data/mm_repository.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../../base/library_item_model.dart';
import '../../../../model/start_game.dart';

class MMController extends SuperController<bool> {

  var station = StationService.to.currentStation;
  var organization = StationService.to.organization;

  late List<GameVariant> games = station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.mmGameVariants!.data!;
  late List<GameVariant> videos = station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.promotionVideos!.data!;

  GameVariant? currentRunningItem ;
  int? currentScoreId ;

  final IMMRepository mmRepository;

  late StreamSubscription subscription;

  RxInt dropIndex = (-1).obs ;

  RxList<GameVariant> timelineItems = RxList();
  RxList<GameVariant> originalTimelineItems = RxList();
  bool isGameStarting = false ;
  RxBool isPaused = true.obs ;
  RxBool replayEnabled = false.obs;

  MMController(
      {required this.mmRepository});

  @override
  void onInit() {
    super.onInit();

    subscription = StationService.to.gameStatus.listen((status) async {

      var type = status.type ;
      var scoreId = status.data["id"] ;
      print("---------------------- NEW EVENT --------------------------") ;
      print("${status.type} ${scoreId} ") ;

      switch (status.type) {
        case GameStatusType.IDLE:
          break;
        case GameStatusType.STARTING:
        // no need its mean the game starting command send from pleyohub
          break;
        case GameStatusType.STARTED:
        // Get.rootDelegate.backUntil(Routes.SELECT_GAME_DIFFICULTY) ;
          isGameStarting = false ;
          break;
        case GameStatusType.FINISHED:
          if(scoreId == currentScoreId){
            await playNextGame();
          }
          break;
        case GameStatusType.CLOSED:
        case GameStatusType.CRASHED:
          if(scoreId == currentScoreId){
            await playNextGame();
          }
          break;
        case GameStatusType.UPDATED:
          //we don't have it in this mode
          break;
        case GameStatusType.PAUSED:
          isPaused.value = true;
          break;
        case GameStatusType.RESUMED:
          isPaused.value = false;
          break;
      }
    });
  }

  Future<void> playPlayList() async {
    try {
      if (currentRunningItem == null || isPaused.value) {
        // If no game is running or the current game is paused, create a new game or resume
        if (currentRunningItem == null) {
          // Create a new multiplayer game
          final item = timelineItems[0] ;
          final gameDifficulty = 1; // Replace with actual game difficulty if available
          final stationId = station.id;
          final organizationId = organization.id;

          MultiplayerGame newGame = await mmRepository.createMMGame(
            gameVariant: item.id!,
            gameDifficulty: gameDifficulty,
            station: stationId!,
            organization: organizationId!,
            numberOfPlayers: item.attributes!.maxNumberOfPlayers!,
          );

          currentRunningItem = item;
          currentScoreId = newGame.id;
        } else {
          // Resume the paused game
          await mmRepository.resumeGame(multiplayerGameId: currentScoreId!);
        }

        isPaused.value = false ;
        isGameStarting = true;
      } else {
        // If a game is already running, no action needed
        print("A game is already running");
      }
    } catch (e) {
      print("Error starting playlist: $e");
      rethrow;
    }
  }

  Future<void> playNextGame() async {
    try {
      resetCurrentGame();
      if (timelineItems.isNotEmpty) {
        timelineItems.removeAt(0);
        if (timelineItems.isNotEmpty) {
          await playPlayList();
        } else {
          if (replayEnabled.value) {
            timelineItems.addAll(originalTimelineItems);
            await playPlayList();
          } else {
            currentRunningItem = null;
            currentScoreId = null;
            isPaused.value = true;
            print("Playlist finished");
          }
        }
      }
    } catch (e) {
      print("Error playing next game: $e");
      rethrow;
    }
  }

  Future<void> playPreviousGame() async {
    try {
      resetCurrentGame();
      if (timelineItems.isNotEmpty && currentRunningItem != null) {
        timelineItems.insert(0, currentRunningItem!);
        await playPlayList();
      }
    } catch (e) {
      print("Error playing previous game: $e");
      rethrow;
    }
  }

  Future<void> playNext() async {
    if (currentRunningItem != null) {
      await stopGame();
    }
    await playNextGame();
  }

  Future<void> playPrevious() async {
    if (currentRunningItem != null) {
      await stopGame();
    }
    await playPreviousGame();
  }

Future<void> pauseGame() async {
  try {
    if (currentRunningItem != null && !isPaused.value) {
      await mmRepository.pauseGame(multiplayerGameId: currentScoreId!);
      isPaused.value = true;
      print("Game paused");
    } else {
      print("No running game to pause or game already paused");
    }
  } catch (e) {
    print("Error pausing game: $e");
    rethrow;
  }
}

  Future<void> stopGame() async {
    try {
      if (currentRunningItem != null && !isPaused.value) {
        await mmRepository.stopGame(multiplayerGameId: currentScoreId!);
        resetCurrentGame();
        print("Game stopped");
      } else {
        print("No running game to stop");
      }
    } catch (e) {
      print("Error stopping game: $e");
      rethrow;
    }
  }

  void resetCurrentGame() {
    currentRunningItem = null;
    currentScoreId = null;
        isPaused.value = true;
    }

  int calculateSessionDuration () {
    if(timelineItems.isEmpty) return 0 ;
    if(timelineItems.length == 1) return timelineItems[0].duration??0 ;
    return timelineItems.map((element) => element.duration ?? 0).reduce((value, element) => value + element);
  }

  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final secs = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
