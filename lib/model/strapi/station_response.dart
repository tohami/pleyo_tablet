import 'package:pleyo_tablet_app/model/strapi/station.dart';

class StationResponse {
  Station? data;

  StationResponse({this.data});

  StationResponse.fromJson(dynamic json) {
    data = json['data'] != null ? new Station.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

