import 'game_variant_response.dart';

class Organization {
  int? id;
  _Attributes? attributes;

  Organization({this.id, this.attributes});

  Organization.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? contactEmail;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  bool? licenceActive;
  Configuration? configuration;

  _Attributes(
      {this.name,
        this.address,
        this.contactEmail,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.licenceActive,
        this.configuration});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    contactEmail = json['contactEmail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    licenceActive = json['licenceActive'];
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['contactEmail'] = this.contactEmail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['licenceActive'] = this.licenceActive;
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    return data;
  }
}

class Configuration {
  ConfigurationData? data;

  Configuration({this.data});

  Configuration.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ConfigurationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ConfigurationData {
  int? id;
  ConfigurationAttributes? attributes;

  ConfigurationData({this.id, this.attributes});

  ConfigurationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new ConfigurationAttributes.fromJson(json['attributes'])
        : null;
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

class ConfigurationAttributes {
  String? createdAt;
  String? updatedAt;
  List<GroupTemplates>? groupTemplates;
  GameVariantsResponse? groupGameVariants;
  GameVariantsResponse? multiplayerGameVariants;
  GameVariantsResponse? singlePlayGameVariants;
  GameVariantsResponse? competitionGameVariants;

  ConfigurationAttributes({this.createdAt, this.updatedAt, this.groupTemplates});

  ConfigurationAttributes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['groupTemplates'] != null) {
      groupTemplates = <GroupTemplates>[];
      json['groupTemplates'].forEach((v) {
        groupTemplates!.add(new GroupTemplates.fromJson(v));
      });
    }
    groupGameVariants = json['groupGameVariants'] != null ? new GameVariantsResponse.fromJson(json['groupGameVariants']) : null;
    multiplayerGameVariants = json['multiplayerGameVariants'] != null ? new GameVariantsResponse.fromJson(json['multiplayerGameVariants']) : null;
    singlePlayGameVariants = json['singlePlayGameVariants'] != null ? new GameVariantsResponse.fromJson(json['singlePlayGameVariants']) : null;
    competitionGameVariants = json['competitionGameVariants'] != null ? new GameVariantsResponse.fromJson(json['competitionGameVariants']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.groupTemplates != null) {
      data['groupTemplates'] =
          this.groupTemplates!.map((v) => v.toJson()).toList();
    }
    if (this.groupGameVariants != null) {
      data['groupGameVariants'] = this.groupGameVariants!.toJson();
    }
    if (this.multiplayerGameVariants != null) {
      data['multiplayerGameVariants'] = this.multiplayerGameVariants!.toJson();
    }

    if (this.singlePlayGameVariants != null) {
      data['singlePlayGameVariants'] = this.singlePlayGameVariants!.toJson();
    }

    if (this.competitionGameVariants != null) {
      data['competitionGameVariants'] = this.competitionGameVariants!.toJson();
    }

    return data;
  }
}

class GroupTemplates {
  int? id;
  String? name;
  int? numberOfPlayers;
  int? numberOfTurns;

  GroupTemplates(
      {this.id, this.name, this.numberOfPlayers, this.numberOfTurns});

  GroupTemplates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numberOfPlayers = json['numberOfPlayers'];
    numberOfTurns = json['numberOfTurns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['numberOfPlayers'] = this.numberOfPlayers;
    data['numberOfTurns'] = this.numberOfTurns;
    return data;
  }
}