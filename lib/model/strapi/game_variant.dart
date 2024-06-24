import 'package:pleyo_tablet_app/base/library_item_model.dart';
import 'package:pleyo_tablet_app/model/strapi/game_difficulty_response.dart';
import 'package:pleyo_tablet_app/model/strapi/game_response.dart';

import 'Image.dart';

class GameVariant /*implements LibraryItemModel*/ {
  int? id;
  Attributes? attributes;
  int? internalId;

  GameVariant({this.id, this.attributes, this.internalId});

  GameVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? new Attributes.fromJson(json['attributes']) : null;
    internalId = json['internalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    data['internalId'] = this.internalId;
    return data;
  }

  GameVariant copyWith({int? id, Attributes? attributes, int? internalId}) {
    return GameVariant(
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      internalId: internalId ?? this.internalId,
    );
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is GameVariant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // @override
  // TODO: implement description
  String get description => "${attributes?.minNumberOfPlayers} - ${attributes?.maxNumberOfPlayers} Players";

  // @override
  // TODO: implement duration
  int? get duration => attributes?.duration;

  // @override
  // TODO: implement image
  String? get image => attributes?.image?.data?.attributes?.url;

  // @override
  // TODO: implement name
  String? get name => attributes?.name;

  @override
  // TODO: implement type
  String get type => attributes?.maxNumberOfPlayers != null ? "GAME" : "VIDEO";

}

class Attributes {
  String? name;
  int? gamehubId;
  String? description;
  String? subtitle;
  int? duration;
  int? minNumberOfPlayers;
  int? maxNumberOfPlayers;
  ImageResponse? image;
  GameDifficultyResponse? gameDifficulties;
  GameResponse? game;

  Attributes({this.name, this.description, this.subtitle, this.image, this.gameDifficulties, this.game});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gamehubId = json['gamehubId'];
    description = json['description'];
    subtitle = json['subtitle'];
    duration = json['duration'];
    minNumberOfPlayers = json['minNumberOfPlayers'];
    maxNumberOfPlayers = json['maxNumberOfPlayers'];
    image = json['image'] != null ? new ImageResponse.fromJson(json['image']) : null;
    gameDifficulties = json['game_difficulties'] != null ? new GameDifficultyResponse.fromJson(json['game_difficulties']) : null;
    game = json['game'] != null ? new GameResponse.fromJson(json['game']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gamehubId'] = this.gamehubId;
    data['description'] = this.description;
    data['subtitle'] = this.subtitle;
    data['duration'] = this.duration;
    data['minNumberOfPlayers'] = this.minNumberOfPlayers;
    data['maxNumberOfPlayers'] = this.maxNumberOfPlayers;
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
