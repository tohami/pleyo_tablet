import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';

abstract class IMMProvider {
  Future<Response<MultiplayerGame>> createMMGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required int organization,
    required int numberOfPlayers,
  });

  Future<Response> stopGame({
    required int multiplayerGameId,
  });

  Future<Response> pauseGame({
    required int multiplayerGameId,
  });

  Future<Response> resumeGame({
    required int multiplayerGameId,
  });
}

class MMProvider extends BaseProvider implements IMMProvider {
  @override
  Future<Response<MultiplayerGame>> createMMGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required int organization,
    required int numberOfPlayers,
  }) {
    return post<MultiplayerGame>(
      'massive-multiplayers',
      {
        "data": {
          "game_variant": gameVariant,
          "game_difficulty": gameDifficulty,
          "station": station,
          "organization": organization,
          "numberOfPlayers": numberOfPlayers,
        }
      },
      decoder: MultiplayerGame.fromJson,
    );
  }

  @override
  Future<Response> stopGame({
    required int multiplayerGameId
  }) {
    return post(
      'massive-multiplayers/$multiplayerGameId/gameUpdates',
      {
        "CommandeId": "GAME_STOP",
      },
    );
  }

  @override
  Future<Response> pauseGame({
    required int multiplayerGameId,
  }) {
    return post(
      'massive-multiplayers/$multiplayerGameId/gameUpdates',
      {
        "CommandeId": "GAME_PAUSE",
      },
    );
  }

  @override
  Future<Response> resumeGame({
    required int multiplayerGameId,
  }) {
    return post(
      'massive-multiplayers/$multiplayerGameId/gameUpdates',
      {
        "CommandeId": "GAME_RESUME",
      },
    );
  }
}
