class GameStartedData {
  int? difficultyPlayed;
  int? gameDuration;
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
        this.dateTime});

  GameStartedData.fromJson(Map<dynamic, dynamic> json) {
    difficultyPlayed = json['DifficultyPlayed'];
    gameDuration = json['GameDuration'];
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
    return data;
  }
}