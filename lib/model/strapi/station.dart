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
  // GameVariantsResponse? gameVariants;
  OrganizationResponse? organization;
  String? tabletSerial;
  bool? isEnabled;
  bool? singlePlayerEnabled;
  bool? groupEnabled;
  bool? multiplayerEnabled;
  bool? competitionEnabled;
  bool? massiveMultiplayerEnabled;

  _Attributes({this.name, this.organization, this.tabletSerial,  this.isEnabled});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    // gameVariants = json['game_variants'] != null ? new GameVariantsResponse.fromJson(json['game_variants']) : null;
    organization = json['organization'] != null ? new OrganizationResponse.fromJson(json['organization']) : null;
    tabletSerial = json['tablet_serial'];
    isEnabled = json['isEnabled'];
    singlePlayerEnabled = json['singlePlayerEnabled'];
    groupEnabled = json['groupEnabled'];
    multiplayerEnabled = json['multiplayerEnabled'];
    competitionEnabled = json['competitionEnabled'];
    massiveMultiplayerEnabled = json['massiveMultiplayerEnabled'];
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    // if (this.gameVariants != null) {
    //   data['game_variants'] = this.gameVariants!.toJson();
    // }
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['tablet_serial'] = this.tabletSerial;

    data['isEnabled'] = this.isEnabled;
    data['singlePlayerEnabled'] = this.singlePlayerEnabled;
    data['competitionEnabled'] = this.competitionEnabled;
    data['groupEnabled'] = this.groupEnabled;
    data['multiplayerEnabled'] = this.multiplayerEnabled;
    data['massiveMultiplayerEnabled'] = this.massiveMultiplayerEnabled;
    return data;
  }
}