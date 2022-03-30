import 'game_model.dart';

class MachineModel {
  String? ethernetMacAdress;
  List<GameVariationList>? gameVariationList;
  String? idMachine;
  String? name;
  String? teamviewerId;
  String? wifiMacAdress;
  String? windowsKey;
  String? windowsName;

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
    ethernetMacAdress = json['EthernetMacAdress'];
    if (json['GameVariationList'] != null) {
      gameVariationList = <GameVariationList>[];
      json['GameVariationList'].forEach((v) {
        gameVariationList!.add(GameVariationList.fromJson(v));
      });
    }
    idMachine = json['IdMachine'];
    name = json['Name'];
    teamviewerId = json['TeamviewerId'];
    wifiMacAdress = json['WifiMacAdress'];
    windowsKey = json['WindowsKey'];
    windowsName = json['WindowsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EthernetMacAdress'] = ethernetMacAdress;
    if (gameVariationList != null) {
      data['GameVariationList'] =
          gameVariationList!.map((v) => v.toJson()).toList();
    }
    data['IdMachine'] = idMachine;
    data['Name'] = name;
    data['TeamviewerId'] = teamviewerId;
    data['WifiMacAdress'] = wifiMacAdress;
    data['WindowsKey'] = windowsKey;
    data['WindowsName'] = windowsName;
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
