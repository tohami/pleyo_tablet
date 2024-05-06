class JoinMultiplayerGameDetails {
  int? multiplayerGame;
  String? gameVariant;
  HostDetails? host;

  JoinMultiplayerGameDetails({
    this.multiplayerGame,
    this.gameVariant,
    this.host,
  });

  factory JoinMultiplayerGameDetails.fromJson(Map<String, dynamic> json) => JoinMultiplayerGameDetails(
    multiplayerGame: json['multiplayerGame'],
    gameVariant: json['game_variant'],
    host: HostDetails.fromJson(json['host']),
  );
}

class HostDetails {
  String? stationName;
  String? playerNickname;
  int? stationId;

  HostDetails({
    this.stationName,
    this.playerNickname,
    this.stationId,
  });

  factory HostDetails.fromJson(Map<String, dynamic> json) => HostDetails(
    stationName: json['stationName'],
    playerNickname: json['PlayerNickname'],
    stationId: json['stationId'],
  );
}
