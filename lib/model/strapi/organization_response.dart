import 'organization.dart';

class OrganizationResponse {
  Organization? data;

  OrganizationResponse({this.data});

  OrganizationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Organization.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

