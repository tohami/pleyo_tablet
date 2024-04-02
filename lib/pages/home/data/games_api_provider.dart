import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart' as gc;

import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../model/strapi/scores_response.dart';

abstract class IGamesProvider {
  Future<Response<ScoreResponse>> startGame(gameDifficulty, gameVariant, ticketId) ;
  Future<Response<ScoreResponse>> updateScoreStatus(String status,int scoreId, {String? reason}) ;
  Future<Response<LeaderboardApiResponse>> listScores(String competition, String game) ;
}

class GamesProvider extends BaseProvider
    implements IGamesProvider {
  @override
  Future<Response<ScoreResponse>> startGame(gameDifficulty, gameVariant, ticketId) {
    // TODO: implement getAllMerchantsr
    int? stationId = StationService.to.currentStation.id ;

    return post<ScoreResponse>('stations/$stationId/startGame', {
      "data" : {
        "game_difficulty" : gameDifficulty,
        "game_variant" : gameVariant,
        "ticket":ticketId
      } } , decoder: ScoreResponse.fromJson);
  }

  @override
  Future<Response<ScoreResponse>> updateScoreStatus(
      String status, int scoreId , {String? reason}) {
    int? stationId = StationService.to.currentStation.id ;

    return post<ScoreResponse>(
        'stations/$stationId/updateScoreStatus',
        {
          "CommandeId": status,
          "ScoreId": scoreId,
          "Reason" : reason
        },
        decoder: ScoreResponse.fromJson);
  }

  Future<Response<LeaderboardApiResponse>> listScores(competition, game) {
    // TODO: implement getAllMerchantsr
    return get<LeaderboardApiResponse>("stations/getLeaderBoard?GlobalLeaderboardName=$competition&IdGame=$game&withTeamStatus=false", decoder: LeaderboardApiResponse.fromJson);
  }
}
