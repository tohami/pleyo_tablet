import 'game.dart';

class GameResponse {
  Game? data;

  GameResponse({this.data});

  GameResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Game.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

