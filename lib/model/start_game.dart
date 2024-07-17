enum GameStatusType {
  IDLE , STARTING , STARTED , FINISHED , CLOSED , CRASHED, UPDATED , PAUSED , RESUMED
}

extension GameStatusTypeExtentsions on GameStatusType {
  /// Returns a `RxString` with [this] `String` as initial value.
  String get title  {
    switch (this) {
      case GameStatusType.IDLE:
        return "Idle";
      case GameStatusType.STARTING:
        return "Loading";
      case GameStatusType.STARTED:
        return "Started";
      case GameStatusType.FINISHED:
        return "Ended";
      case GameStatusType.CLOSED:
        return "Ended";
      case GameStatusType.CRASHED:
        return "Error";
      case GameStatusType.UPDATED:
        return "Updated";
      case GameStatusType.PAUSED:
        return "Paused";
      case GameStatusType.RESUMED:
        return "Resumed";
    }
  }
}

class GameStatus {
  final GameStatusType type ;
  final Map data ;

  GameStatus(this.type, this.data);
}