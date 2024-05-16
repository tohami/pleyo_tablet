class MultiplayerGame {
  int? id;
  int? numberOfPlayers;
  String? unityRoomId;
  List<Score>? scores;

  MultiplayerGame({
    this.id,
    this.numberOfPlayers,
    this.unityRoomId,
    this.scores,
  });

  factory MultiplayerGame.fromJson(dynamic json) => MultiplayerGame(
    id: json['data']?['id'],
    numberOfPlayers: json["data"]?['attributes']?['numberOfPlayers'],
    unityRoomId: json["data"]?['attributes']?['unityRoomId'],
    scores: json["data"]?['attributes']?['scores']?['data'] != null ? List<Score>.from(json["data"]?['attributes']?['scores']?['data']?.map((x) => Score.fromJson(x))) : [],
  );
}

class Score {
  int? id;
  int? score;
  Ticket? ticket;
  Station? station;

  Score({
    this.id,
    this.score,
    this.ticket,
    this.station,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    id: json['id'],
    score: json['attributes']?['score'],
    ticket: json['attributes']?['ticket']?['data'] != null ? Ticket.fromJson(json['attributes']?['ticket']?['data']) : null,
    station: json['attributes']?['station']?['data'] != null ?Station.fromJson(json['attributes']?['station']?['data']) : null,
  );
}

class Station {
  int? id;
  String? name;

  Station({
    this.id,
    this.name
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: json['id'],
    name: json['attributes']?['name'],
  );
}

class Ticket {
  int? id;
  String? nickname;

  Ticket({
    this.id,
    this.nickname,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json['id'],
    nickname: json['attributes']?['nickname'],
  );
}