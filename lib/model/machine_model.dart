import 'game_model.dart';

class MachineModel {
  List<GameVariationList>? gameVariationList;
  String? idMachine;
  String? name;

  MachineModel(
      {ethernetMacAdress,
        gameVariationList,
        idMachine,
        name,
        teamviewerId,
        wifiMacAdress,
        windowsKey,
        windowsName});

  MachineModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['GameVariationList'] != null) {
      gameVariationList = <GameVariationList>[];
      json['GameVariationList'].forEach((v) {
        gameVariationList!.add(GameVariationList.fromJson(v));
      });
    }
    idMachine = json['IdMachine'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gameVariationList != null) {
      data['GameVariationList'] =
          gameVariationList!.map((v) => v.toJson()).toList();
    }
    data['IdMachine'] = idMachine;
    data['Name'] = name;
    return data;
  }
}

class GameVariationList {
  String? idGame;
  List<VariationList>? variationList;

  GameVariationList({idGame, variationList});

  GameVariationList.fromJson(Map<dynamic, dynamic> json) {
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
    data['IdGame'] = idGame;
    if (variationList != null) {
      data['VariationList'] =
          variationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
