class Game {
  int? id;
  _Attributes? attributes;

  Game({this.id, this.attributes});

  Game.fromJson(Map<String, dynamic> json) {
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

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is Game && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

}

class _Attributes {
  String? name;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? gamehubId ;

  _Attributes({this.name, this.location, this.createdAt, this.updatedAt , this.gamehubId});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    gamehubId = json['gamehubId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['gamehubId'] = this.gamehubId;
    return data;
  }
}
