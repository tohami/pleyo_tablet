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
  Formats? formats;
  String? hash;
  String? ext;
  String? mime;
  String? url;
  String? previewUrl;
  String? provider;
  String? folderPath;
  String? createdAt;
  String? updatedAt;

  _Attributes(
      {
        this.name,
        this.alternativeText,
        this.caption,
        this.width,
        this.height,
        this.formats,
        this.hash,
        this.ext,
        this.mime,
        this.url,
        this.previewUrl,
        this.provider,
        this.folderPath,
        this.createdAt,
        this.updatedAt});

  _Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    url = json['url'];
    previewUrl = json['previewUrl'];
    provider = json['provider'];
    folderPath = json['folderPath'];
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
    if (this.formats != null) {
      data['formats'] = this.formats!.toJson();
    }
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    data['provider'] = this.provider;
    data['folderPath'] = this.folderPath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Formats {
  ImageVariant? small;
  ImageVariant? medium;
  ImageVariant? thumbnail;

  Formats({this.small, this.medium, this.thumbnail});

  Formats.fromJson(Map<String, dynamic> json) {
    small = json['small'] != null ? new ImageVariant.fromJson(json['small']) : null;
    medium =
    json['medium'] != null ? new ImageVariant.fromJson(json['medium']) : null;
    thumbnail = json['thumbnail'] != null
        ? new ImageVariant.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.small != null) {
      data['small'] = this.small!.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium!.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
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
