import 'dart:io';

import 'package:pleyo_tablet_app/model/strapi/personas.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import 'game_variant.dart';

class GroupCompetition {
  int? id;
  String? name;
  String? type;
  String? startDate;
  String? endDate;
  int? playersCount;
  int? playerCredit;
  bool? isEnabled;
  bool? startWithFirstGame;
  bool? isStarted;
  int? duration;
  List<Ticket>? tickets;
  GameVariant? gameVariant;
  List<Game>? games;
  Ticket? currentPlayerTurn; // Added field
  bool? isEnded; // Added field
  List<int>? stations ;
  int? organization ;

  GroupCompetition({
    this.id,
    this.stations,
    this.name,
    this.type,
    this.startDate,
    this.endDate,
    this.playersCount,
    this.playerCredit,
    this.isEnabled,
    this.startWithFirstGame,
    this.isStarted,
    this.duration,
    this.tickets,
    this.gameVariant,
    this.games,
    this.currentPlayerTurn, // Added constructor parameter
    this.isEnded,
    this.organization
  });

  GroupCompetition.fromJson(dynamic data) {
    print(data) ;
    var json = data["data"] ;
    id = json['id'];
    name = json['attributes']['name'];
    type = json['attributes']['type'];
    startDate = json['attributes']['startDate'];
    endDate = json['attributes']['endDate'];
    playersCount = json['attributes']['playersCount'];
    playerCredit = json['attributes']['playerCredit'];
    isEnabled = json['attributes']['isEnabled'];
    startWithFirstGame = json['attributes']['startWithFirstGame'];
    isStarted = json['attributes']['isStarted'];
    duration = json['attributes']['duration'];
    tickets = (json['attributes']['tickets']['data'] as List).map((v) => Ticket.fromJson(v)).toList();
    gameVariant = json['attributes']['game_variant'] != null ? GameVariant.fromJson(json['attributes']['game_variant']['data']) : null;
    games = (json['attributes']['games']['data'] as List).map((v) => Game.fromJson(v)).toList();
    currentPlayerTurn = json['attributes']['currentPlayerTurn'] != null ? Ticket.fromJson(json['attributes']['currentPlayerTurn']['data']) : null; // Added field parsing
    isEnded = json['attributes']['isEnded']; // Added field parsing
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['attributes'] = {
      'name': this.name,
      'type': this.type,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'playersCount': this.playersCount,
      'playerCredit': this.playerCredit,
      'isEnabled': this.isEnabled,
      'startWithFirstGame': this.startWithFirstGame,
      'isStarted': this.isStarted,
      'duration': this.duration,
      'tickets': this.tickets?.map((v) => v.toJson()).toList(),
      'game_variant': this.gameVariant?.id,
      'games': this.games?.map((v) => v.id).toList(),
      // 'currentPlayerTurn': this.currentPlayerTurn?.id,
      'isEnded': this.isEnded,
      "stations": stations,
      "organization":organization
    };
    return data;
  }
}

class Ticket {
  int? id;
  int? credit;
  bool? isEnabled;
  String? secret;
  bool? isActivated;
  String? nickname;
  dynamic extraData;
  String? uid;
  Avatar? avatar;
  int? playOrder;
  List<Score>? scores;


  Ticket({
    this.id,
    this.credit,
    this.isEnabled,
    this.secret,
    this.isActivated,
    this.nickname,
    this.extraData,
    this.uid,
    this.avatar,
    this.playOrder,
    this.scores// Added constructor parameter
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    credit = json['attributes']['credit'];
    isEnabled = json['attributes']['isEnabled'];
    secret = json['attributes']['secret'];
    isActivated = json['attributes']['isActivated'];
    nickname = json['attributes']['nickname'];
    extraData = json['attributes']['extraData'];
    uid = json['attributes']['uid'];
    avatar = json['attributes']['avatar'] != null ? new Avatar.fromJson(json['attributes']['avatar']) : null;
    playOrder = json['attributes']['playOrder'];
    if(json['attributes']['scores'] != null) {
      scores = (json['attributes']['scores']['data'] as List).map((v) =>
          Score.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'credit': this.credit,
      'isEnabled': this.isEnabled,
      'secret': this.secret,
      'isActivated': this.isActivated,
      'nickname': this.nickname,
      'extraData': this.extraData,
      'uid': this.uid,
      'playOrder': this.playOrder,
    };
    if (this.avatar != null) {
      data['avatar'] = this.avatar?.data?.id;
    }
    return data;
  }
}

class Score {
  int? id;
  int? score;
  bool? visible;
  bool? completed;

  Score({
    this.id,
    this.score,
    this.visible,
    this.completed,
  });

  Score.fromJson(dynamic json) {
    id = json['id'];
    score = json['attributes']['score'];
    visible = json['attributes']['visible'];
    completed = json['attributes']['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['attributes'] = {
      'score': this.score,
      'visible': this.visible,
      'completed': this.completed,
    };
    return data;
  }
}


class Game {
  int? id;
  String? name;
  int? gamehubId;

  Game({
    this.id,
    this.name,
    this.gamehubId,
  });

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['attributes']['name'];
    gamehubId = json['attributes']['gamehubId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['attributes'] = {
      'name': this.name,
      'gamehubId': this.gamehubId,
    };
    return data;
  }
}
