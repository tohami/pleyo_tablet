class ActivationScreen {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;
  List<Fields>? fields;

  ActivationScreen(
      {this.id, this.title, this.createdAt, this.updatedAt, this.fields});

  ActivationScreen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  int? id;
  String? key;
  String? title;
  String? type;
  bool? required;
  bool? isLeaderboardGrouping;
  List<Options>? options;

  Fields(
      {this.id,
        this.key,
        this.title,
        this.type,
        this.required,
        this.isLeaderboardGrouping,
        this.options});

  Fields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    title = json['title'];
    type = json['type'];
    required = json['required'];
    isLeaderboardGrouping = json['isLeaderboardGrouping'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['title'] = this.title;
    data['type'] = this.type;
    data['required'] = this.required;
    data['isLeaderboardGrouping'] = this.isLeaderboardGrouping;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? text;
  String? value;

  Options({this.id, this.text, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['Text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}