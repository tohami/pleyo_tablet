import 'package:pleyo_tablet_app/model/strapi/competition.dart';

class Ticket {
  int? id;
  TicketAttributes? attributes;

  Ticket({this.id, this.attributes});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new TicketAttributes.fromJson(json['attributes'])
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

class TicketAttributes {
  int? credit;
  bool? isEnabled;
  String? secret;
  bool? isActivated;
  String? nickname;
  dynamic? extraData;
  Competition? competition;
  int? organization ;

  TicketAttributes(
      {this.credit, this.isEnabled, this.secret, this.isActivated, this.nickname, this.extraData, this.competition, this.organization});

  TicketAttributes.fromJson(Map<String, dynamic> json) {
    credit = json['credit'];
    isEnabled = json['isEnabled'];
    secret = json['secret'];
    isActivated = json['isActivated'];
    nickname = json['nickname'];
    extraData = json['extraData'];
    competition = json['competition'] != null
        ? new Competition.fromJson(json['competition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit'] = credit;
    data['isEnabled'] = isEnabled;
    data['secret'] = secret;
    data['isActivated'] = isActivated;
    data['nickname'] = nickname;
    data['extraData'] = extraData;
    data['organization'] = organization;
    if (competition != null) {
      data['competition'] = competition!.toJson();
    }
    return data;
  }
}
