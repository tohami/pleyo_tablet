class Competition {
  int? id;
  String? name;
  String? type;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  bool? isEnabled;
  int? playersCount;
  int? playerCredit;
  bool? startWithFirstGame;
  bool? isStarted;
  List<Games>? games;

  Competition(
      {this.id,
        this.name,
        this.type,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt,
        this.isEnabled,
        this.playersCount,
        this.playerCredit,
        this.startWithFirstGame,
        this.isStarted,
        this.games});

  Competition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isEnabled = json['isEnabled'];
    playersCount = json['playersCount'];
    playerCredit = json['playerCredit'];
    startWithFirstGame = json['startWithFirstGame'];
    isStarted = json['isStarted'];
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isEnabled'] = this.isEnabled;
    data['playersCount'] = this.playersCount;
    data['playerCredit'] = this.playerCredit;
    data['startWithFirstGame'] = this.startWithFirstGame;
    data['isStarted'] = this.isStarted;
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  int? id;
  String? name;
  String? location;
  String? createdAt;
  String? updatedAt;

  Games({this.id, this.name, this.location, this.createdAt, this.updatedAt});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}