import 'package:pleyo_tablet_app/model/strapi/personas.dart';

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
  List<Score>? scores;
  List<Ticket>? tickets;
  GameVariant? gameVariant;
  List<Game>? games;
  Ticket? currentPlayerTurn; // Added field
  bool? isEnded; // Added field

  GroupCompetition({
    this.id,
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
    this.scores,
    this.tickets,
    this.gameVariant,
    this.games,
    this.currentPlayerTurn, // Added constructor parameter
    this.isEnded, // Added constructor parameter
  });

  GroupCompetition.fromJson(Map<String, dynamic> json) {
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
    scores = (json['attributes']['scores']['data'] as List).map((v) => Score.fromJson(v)).toList();
    tickets = (json['attributes']['tickets']['data'] as List).map((v) => Ticket.fromJson(v)).toList();
    gameVariant = json['attributes']['game_variant']['data'] != null ? GameVariant.fromJson(json['attributes']['game_variant']['data']) : null;
    games = (json['attributes']['games']['data'] as List).map((v) => Game.fromJson(v)).toList();
    currentPlayerTurn = json['attributes']['currentPlayerTurn'] != null ? Ticket.fromJson(json['attributes']['currentPlayerTurn']) : null; // Added field parsing
    isEnded = json['attributes']['isEnded']; // Added field parsing
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
  int? playOrder; // Added field

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
    this.playOrder, // Added constructor parameter
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
    avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    playOrder = json['attributes']['playOrder']; // Added field parsing
  }
}

class Score {
  int? id;
  String? gameEndDate;
  int? score;
  String? gameStartDate;
  bool? visible;
  bool? completed;
  int? duration;

  Score({
    this.id,
    this.gameEndDate,
    this.score,
    this.gameStartDate,
    this.visible,
    this.completed,
    this.duration,
  });

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameEndDate = json['attributes']['gameEndDate'];
    score = json['attributes']['score'];
    gameStartDate = json['attributes']['gameStartDate'];
    visible = json['attributes']['visible'];
    completed = json['attributes']['completed'];
    duration = json['attributes']['duration'];
  }
}

class GameVariant {
  int? id;
  String? name;
  int? effort;
  String? description;
  String? subtitle;
  int? gamehubId;

  GameVariant({
    this.id,
    this.name,
    this.effort,
    this.description,
    this.subtitle,
    this.gamehubId,
  });

  GameVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['attributes']['name'];
    effort = json['attributes']['effort'];
    description = json['attributes']['description'];
    subtitle = json['attributes']['subtitle'];
    gamehubId = json['attributes']['gamehubId'];
  }
}

class Game {
  int? id;
  String? name;
  dynamic location;
  int? gamehubId;

  Game({
    this.id,
    this.name,
    this.location,
    this.gamehubId,
  });

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['attributes']['name'];
    location = json['attributes']['location'];
    gamehubId = json['attributes']['gamehubId'];
  }
}
