import 'package:pleyo_tablet_app/model/strapi/personas.dart' as ps;
import 'group_competition.dart' as gc ;

class ScoreResponse {
  Score? data;

  ScoreResponse({this.data});

  ScoreResponse.fromJson(dynamic json) {
    data = json['data'] != null ? new Score.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Score {
  int? id;
  Attributes? attributes;

  Score({this.id, this.attributes});

  Score.fromJson(dynamic json) {
    id = json['id'];
    attributes = json['attributes'] != null ? new Attributes.fromJson(json['attributes']) : null;
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

class Attributes {
  String? gameEndDate;
  int? score;
  String? gameStartDate;
  bool? visible;
  bool? completed;
  int? duration;
  List<Competitions>? competitions;

  Attributes({this.gameEndDate, this.score, this.gameStartDate, this.visible, this.completed, this.duration, this.competitions});

  Attributes.fromJson( dynamic json) {
    gameEndDate = json['gameEndDate'];
    score = json['score'];
    gameStartDate = json['gameStartDate'];
    visible = json['visible'];
    completed = json['completed'];
    duration = json['duration'];
    if (json['competitions'] != null) {
      competitions = <Competitions>[];
      json['competitions'].forEach((v) { competitions!.add(new Competitions.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameEndDate'] = this.gameEndDate;
    data['score'] = this.score;
    data['gameStartDate'] = this.gameStartDate;
    data['visible'] = this.visible;
    data['completed'] = this.completed;
    data['duration'] = this.duration;
    if (this.competitions != null) {
      data['competitions'] = this.competitions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Competitions {
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
  String? createdAt;
  String? updatedAt;
  bool? isEnded;
  List<Tickets>? tickets;
  Tickets? currentPlayerTurn;

  Competitions({this.id, this.name, this.type, this.startDate, this.endDate, this.playersCount, this.playerCredit, this.isEnabled, this.startWithFirstGame, this.isStarted, this.duration, this.createdAt, this.updatedAt, this.isEnded, this.tickets, this.currentPlayerTurn});

  Competitions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    playersCount = json['playersCount'];
    playerCredit = json['playerCredit'];
    isEnabled = json['isEnabled'];
    startWithFirstGame = json['startWithFirstGame'];
    isStarted = json['isStarted'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isEnded = json['isEnded'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) { tickets!.add(new Tickets.fromJson(v)); });
    }
    currentPlayerTurn = json['currentPlayerTurn'] != null ? new Tickets.fromJson(json['currentPlayerTurn']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['playersCount'] = this.playersCount;
    data['playerCredit'] = this.playerCredit;
    data['isEnabled'] = this.isEnabled;
    data['startWithFirstGame'] = this.startWithFirstGame;
    data['isStarted'] = this.isStarted;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isEnded'] = this.isEnded;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    if (this.currentPlayerTurn != null) {
      data['currentPlayerTurn'] = this.currentPlayerTurn!.toJson();
    }
    return data;
  }
}

class Tickets {
  int? id;
  String? secret;
  int? credit;
  bool? isEnabled;
  bool? isActivated;
  String? nickname;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  int? playOrder;
  List<Scores>? scores;
	Avatar? avatar;

  Tickets({this.id, this.secret, this.credit, this.isEnabled, this.isActivated, this.nickname, this.createdAt, this.updatedAt, this.publishedAt, this.playOrder, this.scores});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secret = json['secret'];
    credit = json['credit'];
    isEnabled = json['isEnabled'];
    isActivated = json['isActivated'];
    nickname = json['nickname'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    playOrder = json['playOrder'];
    if (json['scores'] != null) {
      scores = <Scores>[];
      json['scores'].forEach((v) { scores!.add(new Scores.fromJson(v)); });
    }
    avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['secret'] = this.secret;
    data['credit'] = this.credit;
    data['isEnabled'] = this.isEnabled;
    data['isActivated'] = this.isActivated;
    data['nickname'] = this.nickname;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['playOrder'] = this.playOrder;
    if (this.scores != null) {
      data['scores'] = this.scores!.map((v) => v.toJson()).toList();
    }
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    return data;
  }

  gc.Ticket mapTicketsToTicket() {
    // Convert the list of Scores to a list of Score objects
    List<gc.Score>? mappedScores = scores?.map((score) => score.mapScoresToScore()).toList();

    ps.AvatarData? avatarData = avatar?.mapAvatarToAvatarData() ;
    // Create and return a new Ticket instance
    return gc.Ticket(
      id: id,
      credit: credit,
      isEnabled: isEnabled,
      secret: secret,
      isActivated: isActivated,
      nickname: nickname,
      extraData: null, // Adjust this based on how you handle extraData
      uid: null, // Assuming UID needs to be set from elsewhere or not applicable
      avatar: ps.Avatar(data: avatarData), // Assuming Avatar needs to be set from elsewhere or not applicable
      playOrder: playOrder,
      scores: mappedScores,
    );
  }

}

class Scores {
  int? id;
  String? gameEndDate;
  int? score;
  String? gameStartDate;
  bool? visible;
  bool? completed;
  int? duration;
  String? createdAt;
  String? updatedAt;

  Scores({this.id, this.gameEndDate, this.score, this.gameStartDate, this.visible, this.completed, this.duration, this.createdAt, this.updatedAt});

  Scores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameEndDate = json['gameEndDate'];
    score = json['score'];
    gameStartDate = json['gameStartDate'];
    visible = json['visible'];
    completed = json['completed'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gameEndDate'] = this.gameEndDate;
    data['score'] = this.score;
    data['gameStartDate'] = this.gameStartDate;
    data['visible'] = this.visible;
    data['completed'] = this.completed;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  gc.Score mapScoresToScore() {
    // Create an instance of Score and assign the id and the populated _Attributes
    gc.Score score = gc.Score(id: id,
      gameEndDate: gameEndDate,
      score: this.score,
      gameStartDate: gameStartDate,
      visible: visible,
      completed: completed,
      duration: duration,
    );

    return score;
  }
}

class Avatar {
	int? id;
	String? name;
	String? alternativeText;
	String? caption;
	int? width;
	int? height;
	String? hash;
	String? ext;
	String? mime;
	double? size;
	String? url;
	String? provider;
	String? folderPath;
	String? createdAt;
	String? updatedAt;

	Avatar({this.id, this.name, this.alternativeText, this.caption, this.width, this.height, this.hash, this.ext, this.mime, this.size, this.url,  this.provider, this.folderPath, this.createdAt, this.updatedAt});

	Avatar.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		alternativeText = json['alternativeText'];
		caption = json['caption'];
		width = json['width'];
		height = json['height'];
		hash = json['hash'];
		ext = json['ext'];
		mime = json['mime'];
		size = json['size'];
		url = json['url'];
		provider = json['provider'];
		folderPath = json['folderPath'];
		createdAt = json['createdAt'];
		updatedAt = json['updatedAt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['alternativeText'] = this.alternativeText;
		data['caption'] = this.caption;
		data['width'] = this.width;
		data['height'] = this.height;
		data['hash'] = this.hash;
		data['ext'] = this.ext;
		data['mime'] = this.mime;
		data['size'] = this.size;
		data['url'] = this.url;
		data['provider'] = this.provider;
		data['folderPath'] = this.folderPath;
		data['createdAt'] = this.createdAt;
		data['updatedAt'] = this.updatedAt;
		return data;
	}

  ps.AvatarData mapAvatarToAvatarData() {
    // Create an instance of AvatarAttributes and populate it with data from Avatar
    ps.AvatarAttributes attributes = ps.AvatarAttributes(
      name: name,
      alternativeText: alternativeText,
      caption: caption,
      width: width,
      height: height,
      hash: hash,
      ext: ext,
      mime: mime,
      size: size,
      url: url,
      provider: provider,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    // Create and return a new AvatarData instance
    return ps.AvatarData(id: id, attributes: attributes);
  }
}
