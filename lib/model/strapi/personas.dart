class PersonaGroup {
  List<PersonaGroupData>? data;

  PersonaGroup({this.data});

  PersonaGroup.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = <PersonaGroupData>[];
      json['data'].forEach((v) {
        data!.add(new PersonaGroupData.fromJson(v));
      });
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

class PersonaGroupData {
  int? id;
  PersonaGroupAttributes? attributes;

  PersonaGroupData({this.id, this.attributes});

  PersonaGroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new PersonaGroupAttributes.fromJson(json['attributes'])
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

class PersonaGroupAttributes {
  String? name;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  List<Personas>? personas;

  PersonaGroupAttributes(
      {this.name,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
        this.personas});

  PersonaGroupAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    if (json['personas'] != null) {
      personas = <Personas>[];
      json['personas'].forEach((v) {
        personas!.add(new Personas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    if (this.personas != null) {
      data['personas'] = this.personas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Personas {
  int? id;
  String? nickname;
  Avatar? avatar;

  Personas({this.id, this.nickname, this.avatar});

  Personas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar =
    json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    return data;
  }
}

class Avatar {
  AvatarData? data;

  Avatar({this.data});

  Avatar.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AvatarData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AvatarData {
  int? id;
  AvatarAttributes? attributes;

  AvatarData({this.id, this.attributes});

  AvatarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new AvatarAttributes.fromJson(json['attributes'])
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


class AvatarAttributes {
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  String? provider;
  String? createdAt;
  String? updatedAt;

  AvatarAttributes(
      {this.name,
        this.alternativeText,
        this.caption,
        this.width,
        this.height,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.url,
        this.provider,
        this.createdAt,
        this.updatedAt});

  AvatarAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['provider'] = this.provider;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}