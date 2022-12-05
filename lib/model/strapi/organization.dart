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

  _Attributes({this.name, this.address, this.contactEmail, this.createdAt, this.updatedAt, this.publishedAt});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    contactEmail = json['contactEmail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['contactEmail'] = this.contactEmail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}