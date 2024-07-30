import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import '../../../model/strapi/multiplayer_game_response.dart';
import '../../../model/strapi/ticket.dart';
import 'multiplayer_api_provider.dart';

abstract class IMultiplayerRepository {
  Future<MultiplayerGame> createMultiplayerGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required String nickname,
    required int organization,
  });

  Future<JoinMultiplayerGameData> joinMultiplayerGame(
      {required int station,
      required int organization,
      required String nickname,
        required int scoreId});
}

class MultiplayerRepository extends BaseRepository
    implements IMultiplayerRepository {
  IMultiplayerProvider provider;

  MultiplayerRepository({required this.provider});

  Future<MultiplayerGame> createMultiplayerGame({
    required int gameVariant,
    required int gameDifficulty,
    required int station,
    required String nickname,
    required int organization,
  }) async {
    // TODO: implement getAllMerchants
    final apiResponse = await provider.createMultiplayerGame(
        gameVariant: gameVariant,
        gameDifficulty: gameDifficulty,
        nickname: nickname,
        organization: organization,
        station: station);
    if (apiResponse.isOk && apiResponse.body != null) {
      return apiResponse.body!;
    } else {
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  Future<JoinMultiplayerGameData> joinMultiplayerGame({
    required int station,
    required String nickname,
    required int organization,
    required int scoreId
  }) async {
    // TODO: implement getAllMerchants
    final apiResponse = await provider.joinMultiplayerGame(
        nickname: nickname, organization: organization, station: station , scoreId:scoreId);
    if (apiResponse.isOk && apiResponse.body != null) {
      return apiResponse.body!;
    } else {
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
// @override
// Future<Score> updateScoreStatus(String status,int scoreId) async{
//   // TODO: implement getAllMerchants
//   final apiResponse = await provider.updateScoreStatus(status,scoreId) ;
//   if(apiResponse.isOk && apiResponse.body?.data != null){
//     return apiResponse.body!.data!;
//   }else {
//     throw(getErrorMessage(apiResponse.bodyString!)) ;
//   }
// }
}
