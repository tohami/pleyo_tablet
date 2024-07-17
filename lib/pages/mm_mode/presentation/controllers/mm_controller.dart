import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/data/mm_repository.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../../base/library_item_model.dart';
import '../../../../model/start_game.dart';
import '../views/mm_timeline_view.dart';

class MMController extends SuperController<bool> {

  var station = StationService.to.currentStation;
  var organization = StationService.to.organization;
  ScrollController scrollController = ScrollController();

  late List<GameVariant> games = station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.mmGameVariants!.data!;
  late List<GameVariant> videos = station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.promotionVideos!.data!;

  GameVariant? currentRunningItem ;
  int? currentScoreId ;

  final IMMRepository mmRepository;

  late StreamSubscription subscription;

  RxInt dropIndex = (-1).obs ;
  RxInt currentGameIndex = (-1).obs;
  Rx<GameStatusType> currentGameStatus = GameStatusType.IDLE.obs ;
  RxList<GameVariant> timelineItems = RxList();
  bool isGameStarting = false ;
  RxBool isPaused = true.obs ;
  RxBool replayEnabled = false.obs;
  RxInt playlistProgress = 0.obs; // Tracks the progress of the playlist in seconds
  Timer? playlistTimer;

  // final double secondToWidthRatio = 2; // Configurable ratio for width per second

  MMController({required this.mmRepository});

  void scrollToCurrentItem() {
    if (currentGameIndex.value >= 0 &&
        currentGameIndex.value < timelineItems.length) {
      final targetPosition = currentGameIndex.value * timelineItemWidth;
      final maxScrollExtent = scrollController.position.maxScrollExtent;

      if (targetPosition <= maxScrollExtent) {
        scrollController.animateTo(
          targetPosition,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    subscription = StationService.to.gameStatus.listen((status) async {

      var type = status.type ;
      currentGameStatus.value = type ;
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
          startTimer();
          scrollToCurrentItem(); // Scroll to the current item when it starts
          break;
        case GameStatusType.FINISHED:
          if(scoreId == currentScoreId){
            await playNext();
          }
          break;
        case GameStatusType.CLOSED:
        case GameStatusType.CRASHED:
          if(scoreId == currentScoreId){
            await playNext();
          }
          break;
        case GameStatusType.UPDATED:
          //we don't have it in this mode
          break;
        case GameStatusType.PAUSED:
          isPaused.value = true;
          stopTimer();
          break;
        case GameStatusType.RESUMED:
          isPaused.value = false;
          startTimer();
          break;
      }
    });
  }

  Future<void> playPlayList() async {
    try {
      if (currentRunningItem == null || isPaused.value) {
        // If no game is running or the current game is paused, create a new game or resume
        if (currentRunningItem == null) {
          if (currentGameIndex.value == -1) {
            currentGameIndex.value = 0;
        }

          final item = timelineItems[currentGameIndex.value];
        final gameDifficulty = 1;
          final stationId = station.id;
          final organizationId = organization.id;

          MultiplayerGame newGame = await mmRepository.createMMGame(
            gameVariant: item.id!,
            gameDifficulty: gameDifficulty,
            station: stationId!,
            organization: organizationId!,
            numberOfPlayers: item.attributes!.maxNumberOfPlayers??0,
          );

          currentRunningItem = item;
          currentScoreId = newGame.id;
          // Sum up the durations of past games to update playlistProgress
          syncTimeLineProgress();
        } else {
          await mmRepository.resumeGame(multiplayerGameId: currentScoreId!);
        }

        isPaused.value = false ;
        isGameStarting = true;
        startTimer();
        scrollToCurrentItem(); // Scroll to the current item when it starts
      } else {
        print("A game is already running");
      }
    } catch (e) {
      print("Error starting playlist: $e");
      rethrow;
    }
  }

  void syncTimeLineProgress () {
    playlistProgress.value = 0;
    for (int i = 0; i < currentGameIndex.value; i++) {
      playlistProgress.value += timelineItems[i].duration ?? 0;
    }
  }

  Future<void> playNext() async {
    try {
      resetCurrentGame();
      currentGameIndex.value++;
      if (currentGameIndex.value >= timelineItems.length) {
        if (replayEnabled.value) {
          currentGameIndex.value = 0;
    } else {
          currentGameIndex.value = -1;
          playlistProgress.value = 0 ;
          print("Playlist finished");
          return;
        }
      }
        await playPlayList();
    } catch (e) {
      print("Error playing next game: $e");
      rethrow;
    }
  }

  Future<void> playPrevious() async {
    try {
      resetCurrentGame();
      currentGameIndex.value--;
      if (currentGameIndex.value < 0) {
        if (replayEnabled.value) {
          currentGameIndex.value = timelineItems.length - 1;
        } else {
          currentGameIndex.value = -1;
          print("No previous game");
          return;
        }
      }
        await playPlayList();
    } catch (e) {
      print("Error playing previous game: $e");
      rethrow;
    }
  }

Future<void> pauseGame() async {
  try {
    if (currentRunningItem != null && !isPaused.value) {
      await mmRepository.pauseGame(multiplayerGameId: currentScoreId!);
      isPaused.value = true;
      stopTimer();
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
    stopTimer();
  }

  void startTimer() {
    // playlistTimer?.cancel();
    // playlistTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if(playlistProgress >= calculateSessionDuration() ){
    //     stopTimer() ;
    //   }else {
    //     playlistProgress.value++;
    //   }
    // });
  }

  void stopTimer() {
    // playlistTimer?.cancel();
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

  void addTimeLineItem(GameVariant data) {
    var newData = data.copyWith(internalId: DateTime.now().millisecondsSinceEpoch);
    if (dropIndex.value != -1) {
      timelineItems
          .insert(dropIndex.value, newData);
    } else {
      timelineItems.add(newData);
    }
    dropIndex.value = -1;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
    playlistTimer?.cancel();
    scrollController.dispose();
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
