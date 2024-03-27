import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';

import 'organization.dart';

class GameVariantsResponse {
  List<GameVariant>? data;

  GameVariantsResponse({this.data});

  GameVariantsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GameVariant>[];
      json['data'].forEach((v) { data!.add(new GameVariant.fromJson(v)); });
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

