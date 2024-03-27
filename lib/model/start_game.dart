enum GameStatusType {
  IDLE , STARTING , STARTED , FINISHED , CLOSED , CRASHED
}

class GameStatus {
  final GameStatusType type ;
  final Map data ;

  GameStatus(this.type, this.data);
}