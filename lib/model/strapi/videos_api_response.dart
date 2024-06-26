import 'package:pleyo_tablet_app/base/library_item_model.dart';

class VideosApiResponse {
  List<StationVideo>? data;

  VideosApiResponse({this.data});

  VideosApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StationVideo>[];
      json['data'].forEach((v) {
        data!.add(new StationVideo.fromJson(v));
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

class StationVideo /*implements LibraryItemModel*/ {
  int? id;
  StationVideoAttributes? attributes;

  StationVideo({this.id, this.attributes});

  StationVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new StationVideoAttributes.fromJson(json['attributes'])
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

  @override
  String? get description => "";

  @override
  // TODO: implement duration
  int? get duration => int.tryParse(attributes?.alternativeText??"");

  @override
  // TODO: implement gamehubId
  int? get objectId => id;

  @override
  // TODO: implement image
  String? get image => attributes?.previewUrl;

  @override
  // TODO: implement name
  String? get name => attributes?.name;

  @override
  // TODO: implement type
  String? get type => "VIDEO";

  @override
  int? internalId;

  @override
  bool isPaused = false ;
}

class StationVideoAttributes {
  String? name;
  String? hash;
  String? ext;
  String? mime;
  String? alternativeText;
  double? size;
  String? url;
  String? previewUrl;

  StationVideoAttributes(
      {this.name,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.url,
        this.previewUrl});

  StationVideoAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    alternativeText = json['alternativeText'];
    size = json['size'];
    url = json['url'];
    previewUrl = json['previewUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['alternativeText'] = this.alternativeText;
    data['size'] = this.size;
    data['url'] = this.url;
    data['previewUrl'] = this.previewUrl;
    return data;
  }
}