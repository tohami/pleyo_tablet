class LeaderboardApiResponse {
  List<TeamsScore>? teamsScore;
  List<Score>? leaderBoard;

  LeaderboardApiResponse({this.teamsScore, this.leaderBoard});

  LeaderboardApiResponse.fromJson(dynamic json) {
    if (json['teamsScore'] != null) {
      teamsScore = <TeamsScore>[];
      json['teamsScore'].forEach((v) {
        teamsScore!.add(new TeamsScore.fromJson(v));
      });
    }
    if (json['leaderBoard'] != null) {
      leaderBoard = <Score>[];
      json['leaderBoard'].forEach((v) {
        leaderBoard!.add(new Score.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamsScore != null) {
      data['teamsScore'] = this.teamsScore!.map((v) => v.toJson()).toList();
    }
    if (this.leaderBoard != null) {
      data['leaderBoard'] = this.leaderBoard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamsScore {
  String? team;
  int? score;

  TeamsScore({this.team, this.score});

  TeamsScore.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team'] = this.team;
    data['score'] = this.score;
    return data;
  }
}

class Score {
  int? id;
  String? dateTime;
  bool? isPartyMode;
  String? partyName;
  String? playerNickName;
  num? score;
  String? team;
  String? avatarUrl ;

  Score(
      {this.id,
        this.dateTime,
        this.isPartyMode,
        this.partyName,
        this.playerNickName,
        this.score,
        this.team,
      this.avatarUrl});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    dateTime = json['DateTime'];
    isPartyMode = json['IsPartyMode'];
    partyName = json['PartyName'];
    playerNickName = json['PlayerNickName'];
    score = json['Score'];
    team = json['team'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DateTime'] = this.dateTime;
    data['IsPartyMode'] = this.isPartyMode;
    data['PartyName'] = this.partyName;
    data['PlayerNickName'] = this.playerNickName;
    data['Score'] = this.score;
    data['team'] = this.team;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}