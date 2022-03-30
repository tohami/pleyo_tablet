class GameModel {
  String? gameName;
  String? idGame;
  List<VariationList>? variationList;

  GameModel({gameName, idGame, variationList});

  GameModel.fromJson(Map<dynamic, dynamic> json) {
    gameName = json['GameName'];
    idGame = json['IdGame'];
    if (json['VariationList'] != null) {
      variationList = <VariationList>[];
      json['VariationList'].forEach((v) {
        variationList!.add(VariationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GameName'] = gameName;
    data['IdGame'] = idGame;
    if (variationList != null) {
      data['VariationList'] =
          variationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationList {
  List<DifficultyAvailable>? difficultyAvailable;
  String? displayedName;
  String? effortValue;
  String? gameInfoText;
  String? idGame;
  String? idMusic;
  String? idVariation;
  String? urlImage;
  String? urlVideoTablet;
  String? variationInfoText;

  VariationList(
      {difficultyAvailable,
        displayedName,
        effortValue,
        gameInfoText,
        idGame,
        idMusic,
        idVariation,
        urlImage,
        urlVideoTablet,
        variationInfoText});

  VariationList.fromJson(Map<dynamic, dynamic> json) {
    if (json['DifficultyAvailable'] != null) {
      difficultyAvailable = <DifficultyAvailable>[];
      json['DifficultyAvailable'].forEach((v) {
        difficultyAvailable!.add(DifficultyAvailable.fromJson(v));
      });
    }
    displayedName = json['DisplayedName'];
    effortValue = json['EffortValue'];
    gameInfoText = json['GameInfoText'];
    idGame = json['IdGame'];
    idMusic = json['IdMusic'];
    idVariation = json['IdVariation'];
    urlImage = json['UrlImage'];
    urlVideoTablet = json['UrlVideoTablet'];
    variationInfoText = json['VariationInfoText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (difficultyAvailable != null) {
      data['DifficultyAvailable'] =
          difficultyAvailable!.map((v) => v.toJson()).toList();
    }
    data['DisplayedName'] = displayedName;
    data['EffortValue'] = effortValue;
    data['GameInfoText'] = gameInfoText;
    data['IdGame'] = idGame;
    data['IdMusic'] = idMusic;
    data['IdVariation'] = idVariation;
    data['UrlImage'] = urlImage;
    data['UrlVideoTablet'] = urlVideoTablet;
    data['VariationInfoText'] = variationInfoText;
    return data;
  }
}

class DifficultyAvailable {
  String? difficulty;

  DifficultyAvailable({difficulty});

  DifficultyAvailable.fromJson(Map<dynamic, dynamic> json) {
    difficulty = json['Difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Difficulty'] = difficulty;
    return data;
  }
}