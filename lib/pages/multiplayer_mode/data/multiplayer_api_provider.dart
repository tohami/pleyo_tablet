import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';

abstract class IMultiplayerProvider {
  Future<Response<MultiplayerGame>> createMultiplayerGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required String nickname,
    required int organization,
  });

  Future<Response<JoinMultiplayerGameData>> joinMultiplayerGame(
      {required int station,
      required int organization,
      required String nickname,
        required int scoreId});
}

class MultiplayerProvider extends BaseProvider implements IMultiplayerProvider {
  @override
  Future<Response<MultiplayerGame>> createMultiplayerGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required String nickname,
    required int organization,
  }) {
    return post<MultiplayerGame>(
        'multiplayers',
        {
          "data": {
            "game_variant": gameVariant,
            "game_difficulty": gameDifficulty,
            "station": station,
            "nickname": nickname,
            "organization": organization
          }
        },
        decoder: MultiplayerGame.fromJson);
  }

  @override
  Future<Response<JoinMultiplayerGameData>> joinMultiplayerGame({
    required int station,
    required String nickname,
    required int organization,
    required int scoreId
  }) {
    return post<JoinMultiplayerGameData>(
        'multiplayers/$scoreId/join',
        {
          "data": {
            "station": station,
            "nickname": nickname,
            "organization": organization
          }
        },
        decoder: JoinMultiplayerGameData.fromJson);
  }
}
