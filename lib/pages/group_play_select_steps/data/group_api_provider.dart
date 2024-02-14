import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';

import 'package:pleyo_tablet_app/services/station_service.dart';

abstract class IGroupsProvider {
  Future<Response<GroupCompetition>> createGroup(GroupCompetition data) ;
  Future<Response<ScoreResponse>> updateScoreStatus(String status,int scoreId) ;
}

class GroupsProvider extends BaseProvider
    implements IGroupsProvider {
  @override
  Future<Response<GroupCompetition>> createGroup(GroupCompetition data) {
    // return post<ScoreResponse>('stations/$stationId/startGroup', {
    //   "data" : {
    //     "group_difficulty" : groupDifficulty,
    //     "group_variant" : groupVariant,
    //     "ticket":ticketId
    //   } } , decoder: ScoreResponse.fromJson);
  }

  @override
  Future<Response<ScoreResponse>> updateScoreStatus(
      String status, int scoreId) {
    int? stationId = StationService.to.currentStation.id ;

    return post<ScoreResponse>(
        'stations/$stationId/updateScoreStatus',
        {
          "CommandeId": status,
          "ScoreId": scoreId,
        },
        decoder: ScoreResponse.fromJson);
  }
}
