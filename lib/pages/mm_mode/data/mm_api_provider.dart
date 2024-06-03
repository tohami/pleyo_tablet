import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';

abstract class IMMProvider {
  Future<Response<MultiplayerGame>> createMultiplayerGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required String nickname,
    required int organization,
  });

  joinMultiplayerGame(
      {required int station,
      required int organization,
      required String nickname,
        required int scoreId});
}

class MMProvider extends BaseProvider implements IMMProvider {
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
  Future<Response<MultiplayerGame>> joinMultiplayerGame({
    required int station,
    required String nickname,
    required int organization,
    required int scoreId
  }) {
    return post<MultiplayerGame>(
        'multiplayers/$scoreId/join',
        {
          "data": {
            "station": station,
            "nickname": nickname,
            "organization": organization
          }
        },
        decoder: MultiplayerGame.fromJson);
  }
}
