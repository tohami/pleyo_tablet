import 'package:pleyo_tablet_app/model/strapi/game_variant_response.dart';
import 'package:pleyo_tablet_app/model/strapi/organization_response.dart';

import 'organization.dart';

class Station {
  int? id;
  _Attributes? attributes;

  Station({this.id, this.attributes});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? new _Attributes.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class _Attributes {
  String? name;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  OrganizationResponse? organization;
  GameVariantsResponse? gameVariants;

  _Attributes({this.name, this.createdAt, this.updatedAt, this.publishedAt, this.organization, this.gameVariants});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    organization = json['organization'] != null ? new OrganizationResponse.fromJson(json['organization']) : null;
    gameVariants = json['game_variants'] != null ? new GameVariantsResponse.fromJson(json['game_variants']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    if (this.gameVariants != null) {
      data['game_variants'] = this.gameVariants!.toJson();
    }
    return data;
  }
}
