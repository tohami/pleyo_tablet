class StrapiError {
  Null? data;
  Error? error;

  StrapiError({this.data, this.error});

  StrapiError.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  int? status;
  String? name;
  String? message;
  Details? details;

  Error({this.status, this.name, this.message, this.details});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    message = json['message'];
    details = json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {

  String? error;

  Details(String? error);

Details.fromJson(Map<String, dynamic> json) {
  error = json['error'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['error'] = this.error;
  return data;
}
}