
class JoinMultiplayerGameData {
  int id;
  GameAttributes? attributes;

  JoinMultiplayerGameData({required this.id, required this.attributes});

  factory JoinMultiplayerGameData.fromJson(dynamic json) {
    return JoinMultiplayerGameData(
      id: json['data']['id'],
      attributes: GameAttributes.fromJson(json['data']['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'attributes': attributes?.toJson(),
      },
    };
  }
}

class GameAttributes {
  int numberOfPlayers;
  Scores? scores;

  GameAttributes({required this.numberOfPlayers, required this.scores});

  factory GameAttributes.fromJson(Map<String, dynamic> json) {
    return GameAttributes(
      numberOfPlayers: json['numberOfPlayers'],
      scores: Scores.fromJson(json['scores']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberOfPlayers': numberOfPlayers,
      'scores': scores?.toJson(),
    };
  }
}

class Scores {
  List<ScoreData?>? data;

  Scores({required this.data});

  factory Scores.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ScoreData> dataList = list.map((i) => ScoreData.fromJson(i)).toList();

    return Scores(data: dataList);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((v) => v?.toJson()).toList(),
    };
  }
}

class ScoreData {
  int id;
  ScoreAttributes? attributes;

  ScoreData({required this.id, required this.attributes});

  factory ScoreData.fromJson(Map<String, dynamic> json) {
    return ScoreData(
      id: json['id'],
      attributes: ScoreAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes?.toJson(),
    };
  }
}

class ScoreAttributes {
  Station? station;

  ScoreAttributes({required this.station});

  factory ScoreAttributes.fromJson(Map<String, dynamic> json) {
    return ScoreAttributes(
      station: Station.fromJson(json['station']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'station': station?.toJson(),
    };
  }
}

class Station {
  StationData? data;

  Station({required this.data});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      data: StationData?.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class StationData {
  int id;

  StationData({required this.id});

  factory StationData.fromJson(Map<String, dynamic> json) {
    return StationData(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
