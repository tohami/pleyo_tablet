class ImageResponse {
  StrapiImage? data;

  ImageResponse({this.data});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new StrapiImage.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}



class StrapiImage {
  int? id;
  _Attributes? attributes;

  StrapiImage(
      {this.id,
      this.attributes});

  StrapiImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    attributes =
    json['attributes'] != null ? new _Attributes.fromJson(json['attributes']) : null;

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
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  String? url;
  String? previewUrl;
  String? provider;

  _Attributes(
      {
        this.name,
        this.alternativeText,
        this.caption,
        this.width,
        this.height,
        this.url,
        this.previewUrl,
        this.provider});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    return data;
  }
}

class ImageVariant {
  String? ext;
  String? url;
  String? hash;
  String? mime;
  String? name;
  String? path;

  ImageVariant(
      {this.ext,
        this.url,
        this.hash,
        this.mime,
        this.name,
        this.path});

  ImageVariant.fromJson(Map<String, dynamic> json) {
    ext = json['ext'];
    url = json['url'];
    hash = json['hash'];
    mime = json['mime'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ext'] = this.ext;
    data['url'] = this.url;
    data['hash'] = this.hash;
    data['mime'] = this.mime;
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}
