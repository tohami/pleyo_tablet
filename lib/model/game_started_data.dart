class GameStartedData {
  int? difficultyPlayed;
  double? gameDuration;
  String? gameName;
  String? globalLeaderboardName;
  int? idGame;
  int? idMachine;
  int? idVariation;
  bool? isPartyMode;
  String? partyName;
  String? playerNickName;
  String? publicHashtag;
  int? score;
  int? dateTime;
  String? teamName ;
  int? teamColor ;

  GameStartedData(
      {this.difficultyPlayed,
        this.gameDuration,
        this.gameName,
        this.globalLeaderboardName,
        this.idGame,
        this.idMachine,
        this.idVariation,
        this.isPartyMode,
        this.partyName,
        this.playerNickName,
        this.publicHashtag,
        this.score ,
        this.dateTime,
        this.teamName,
        this.teamColor});

  GameStartedData.fromJson(Map<dynamic, dynamic> json) {
    difficultyPlayed = json['DifficultyPlayed'];
    try {
      gameDuration = double.parse(json['GameDuration'].toString());
    }catch(e){
      print(e);
    }
    gameName = json['GameName'];
    globalLeaderboardName = json['GlobalLeaderboardName'];
    idGame = json['IdGame'];
    idMachine = json['IdMachine'];
    idVariation = json['IdVariation'];
    isPartyMode = json['IsPartyMode'];
    partyName = json['PartyName'];
    playerNickName = json['PlayerNickName'];
    publicHashtag = json['PublicHashtag'];
    score = json['Score'];
    dateTime = json['DateTime'];
    teamName = json['teamName'];
    teamColor = json['teamColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DifficultyPlayed'] = this.difficultyPlayed;
    data['GameDuration'] = this.gameDuration;
    data['GameName'] = this.gameName;
    data['GlobalLeaderboardName'] = this.globalLeaderboardName;
    data['IdGame'] = this.idGame;
    data['IdMachine'] = this.idMachine;
    data['IdVariation'] = this.idVariation;
    data['IsPartyMode'] = this.isPartyMode;
    data['PartyName'] = this.partyName;
    data['PlayerNickName'] = this.playerNickName;
    data['PublicHashtag'] = this.publicHashtag;
    data['Score'] = this.score;
    data['DateTime'] = this.dateTime;
    data['teamName'] = this.teamName;
    data['teamColor'] = this.teamColor;
    return data;
  }
}