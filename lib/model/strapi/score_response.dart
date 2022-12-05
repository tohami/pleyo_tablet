class ScoreResponse {
  Score? data;

  ScoreResponse({this.data});

  ScoreResponse.fromJson(dynamic json) {
    data = json['data'] != null ? new Score.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Score {
  int? id;
  _Attributes? attributes;

  Score({this.id, this.attributes});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new _Attributes.fromJson(json['attributes'])
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

class _Attributes {
  String? gameEndDate;
  int? score;
  String? gameStartDate;
  bool? visible;
  bool? completed;
  String? createdAt;
  String? updatedAt;

  _Attributes(
      {this.gameEndDate,
        this.score,
        this.gameStartDate,
        this.visible,
        this.completed,
        this.createdAt,
        this.updatedAt});

  _Attributes.fromJson(Map<String, dynamic> json) {
    gameEndDate = json['gameEndDate'];
    score = json['score'];
    gameStartDate = json['gameStartDate'];
    visible = json['visible'];
    completed = json['completed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameEndDate'] = this.gameEndDate;
    data['score'] = this.score;
    data['gameStartDate'] = this.gameStartDate;
    data['visible'] = this.visible;
    data['completed'] = this.completed;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}