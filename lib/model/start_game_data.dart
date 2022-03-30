class StartGameData {
  String? difficultyPlayed;
  String? gameName;
  String? globalLeaderboardName;
  String? idGame;
  String? idMachine;
  String? idVariation;
  String? isOnPartyMode;
  String? partyName;
  String? playerNickName;
  String? publicHashtag;

  StartGameData(
      {this.difficultyPlayed,
        this.gameName,
        this.globalLeaderboardName,
        this.idGame,
        this.idMachine,
        this.idVariation,
        this.isOnPartyMode,
        this.partyName,
        this.playerNickName,
        this.publicHashtag});

  StartGameData.fromJson(Map<String, dynamic> json) {
    difficultyPlayed = json['DifficultyPlayed'];
    gameName = json['GameName'];
    globalLeaderboardName = json['GlobalLeaderboardName'];
    idGame = json['IdGame'];
    idMachine = json['IdMachine'];
    idVariation = json['IdVariation'];
    isOnPartyMode = json['IsOnPartyMode'];
    partyName = json['PartyName'];
    playerNickName = json['PlayerNickName'];
    publicHashtag = json['PublicHashtag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DifficultyPlayed'] = this.difficultyPlayed;
    data['GameName'] = this.gameName;
    data['GlobalLeaderboardName'] = this.globalLeaderboardName;
    data['IdGame'] = this.idGame;
    data['IdMachine'] = this.idMachine;
    data['IdVariation'] = this.idVariation;
    data['IsOnPartyMode'] = this.isOnPartyMode;
    data['PartyName'] = this.partyName;
    data['PlayerNickName'] = this.playerNickName;
    data['PublicHashtag'] = this.publicHashtag;
    return data;
  }
}