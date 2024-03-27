import 'package:pleyo_tablet_app/model/strapi/game_difficulty_response.dart';
import 'package:pleyo_tablet_app/model/strapi/game_response.dart';

import 'Image.dart';

class GameVariant {
  int? id;
  Attributes? attributes;

  GameVariant({this.id, this.attributes});

  GameVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? new Attributes.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is GameVariant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

}

class Attributes {
  String? name;
  int? effort;
  int? gamehubId;
  String? description;
  String? subtitle;
  String? createdAt;
  String? updatedAt;
  ImageResponse? image;
  GameDifficultyResponse? gameDifficulties;
  GameResponse? game;

  Attributes({this.name, this.effort, this.description, this.subtitle, this.createdAt, this.updatedAt,this.image, this.gameDifficulties, this.game});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    effort = json['effort'];
    gamehubId = json['gamehubId'];
    description = json['description'];
    subtitle = json['subtitle'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['image'] != null ? new ImageResponse.fromJson(json['image']) : null;
    gameDifficulties = json['game_difficulties'] != null ? new GameDifficultyResponse.fromJson(json['game_difficulties']) : null;
    game = json['game'] != null ? new GameResponse.fromJson(json['game']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['effort'] = this.effort;
    data['gamehubId'] = this.gamehubId;
    data['description'] = this.description;
    data['subtitle'] = this.subtitle;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.gameDifficulties != null) {
      data['game_difficulties'] = this.gameDifficulties!.toJson();
    }
    if (this.game != null) {
      data['game'] = this.game!.toJson();
    }
    return data;
  }
}
