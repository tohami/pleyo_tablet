import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import '../../../model/strapi/multiplayer_game_response.dart';
import '../../../model/strapi/ticket.dart';
import 'mm_api_provider.dart';

abstract class IMMRepository {
  Future<MultiplayerGame> createMMGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required int organization,
    required int numberOfPlayers,
  });

  Future<void> stopGame({
    required int multiplayerGameId,
  });

  Future<void> pauseGame({
    required int multiplayerGameId,
  });

  Future<void> resumeGame({
    required int multiplayerGameId,
  });
}

class MMRepository extends BaseRepository implements IMMRepository {
  final IMMProvider provider;

  MMRepository({required this.provider});

  @override
  Future<MultiplayerGame> createMMGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required int organization,
    required int numberOfPlayers,
  }) async {
    final apiResponse = await provider.createMMGame(
      gameVariant: gameVariant,
      gameDifficulty: gameDifficulty,
      organization: organization,
      station: station,
      numberOfPlayers: numberOfPlayers,
    );
    if (apiResponse.isOk && apiResponse.body != null) {
      return apiResponse.body!;
    } else {
      throw getErrorMessage(apiResponse.bodyString!);
    }
  }

  @override
  Future<void> stopGame({
    required int multiplayerGameId,
  }) async {
    final apiResponse = await provider.stopGame(
      multiplayerGameId: multiplayerGameId,
    );
    if (!apiResponse.isOk) {
      throw getErrorMessage(apiResponse.bodyString!);
    }
  }

  @override
  Future<void> pauseGame({
    required int multiplayerGameId,
  }) async {
    final apiResponse = await provider.pauseGame(
      multiplayerGameId: multiplayerGameId,
    );
    if (!apiResponse.isOk) {
      throw getErrorMessage(apiResponse.bodyString!);
    }
  }

  @override
  Future<void> resumeGame({
    required int multiplayerGameId,
  }) async {
    final apiResponse = await provider.resumeGame(
      multiplayerGameId: multiplayerGameId,
    );
    if (!apiResponse.isOk) {
      throw getErrorMessage(apiResponse.bodyString!);
    }
  }
}
