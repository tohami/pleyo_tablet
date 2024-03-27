import 'package:pleyo_tablet_app/model/strapi/ticket.dart';

class TicketResponse {
  Ticket? data;

  TicketResponse({this.data});

  TicketResponse.fromJson(dynamic json) {
    data = json['data'] != null ? new Ticket.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}