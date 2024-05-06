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
    id: json['id'],
    numberOfPlayers: json['attributes']?['numberOfPlayers'],
    unityRoomId: json['attributes']?['unityRoomId'],
    scores: json['attributes']?['scores']?['data'] != null ? List<Score>.from(json['attributes']?['scores']?['data']?.map((x) => Score.fromJson(x))) : [],
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
    ticket: Ticket.fromJson(json['attributes']?['ticket']?['data']),
    station: Station.fromJson(json['attributes']?['station']?['data']),
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