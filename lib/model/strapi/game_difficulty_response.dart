
import 'package:pleyo_tablet_app/model/strapi/game_difficulty.dart';

import 'game_variant.dart';

class GameDifficultyResponse {
  List<GameDifficulty>? data ;
  GameDifficultyResponse({this.data});

  GameDifficultyResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GameDifficulty>[];
      json['data'].forEach((v) { data!.add(new GameDifficulty.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

