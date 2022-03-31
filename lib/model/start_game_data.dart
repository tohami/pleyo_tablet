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
  String? dateTime;

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
        this.publicHashtag,
        this.dateTime});

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
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DifficultyPlayed'] = difficultyPlayed;
    data['GameName'] = gameName;
    data['GlobalLeaderboardName'] = globalLeaderboardName;
    data['IdGame'] = idGame;
    data['IdMachine'] = idMachine;
    data['IdVariation'] = idVariation;
    data['IsOnPartyMode'] = isOnPartyMode;
    data['PartyName'] = partyName;
    data['PlayerNickName'] = playerNickName;
    data['PublicHashtag'] = publicHashtag;
    data['dateTime'] = dateTime;
    return data;
  }
}