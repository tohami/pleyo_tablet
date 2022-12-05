class GameDifficulty {
  int? id;
  _Attributes? attributes;

  GameDifficulty({this.id, this.attributes});

  GameDifficulty.fromJson(Map<String, dynamic> json) {
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
  String? color;
  int? difficulty;
  String? createdAt;
  String? updatedAt;

  _Attributes({this.name,this.color, this.difficulty, this.createdAt, this.updatedAt});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    difficulty = json['difficulty'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['difficulty'] = this.difficulty;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
