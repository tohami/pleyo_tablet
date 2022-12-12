import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';

abstract class IGamesProvider {
  Future<Response<ScoreResponse>> startGame(gameDifficulty, gameVariant, ticketId) ;
  Future<Response<ScoreResponse>> updateScoreStatus(String status,int scoreId) ;
}

class GamesProvider extends BaseProvider
    implements IGamesProvider {
  @override
  Future<Response<ScoreResponse>> startGame(gameDifficulty, gameVariant, ticketId) {
    // TODO: implement getAllMerchantsr
    return post<ScoreResponse>('stations/$STATION_ID/startGame', {
      "data" : {
        "game_difficulty" : gameDifficulty,
        "game_variant" : gameVariant,
        "ticket":ticketId
      } } , decoder: ScoreResponse.fromJson);
  }

  @override
  Future<Response<ScoreResponse>> updateScoreStatus(
      String status, int scoreId) {
    // TODO: implement getAllMerchantsr
    return post<ScoreResponse>(
        'stations/$STATION_ID/updateScoreStatus',
        {
          "CommandeId": status,
          "ScoreId": scoreId,
        },
        decoder: ScoreResponse.fromJson);
  }
}
