import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';

import 'package:pleyo_tablet_app/services/station_service.dart';

abstract class IGroupsProvider {
  Future<Response<GroupCompetition>> createGroup(GroupCompetition data);

  Future<Response<ScoreResponse>> updateScoreStatus(String status, int scoreId);
}

class GroupsProvider extends BaseProvider implements IGroupsProvider {
  @override
  Future<Response<GroupCompetition>> createGroup(GroupCompetition data) {
    print(data.toJson()) ;
    return post<GroupCompetition>(
        'competitions', {"data": data.toJson()["attributes"]},
        query: {"populate[0]": "scores",
          "populate[1]": "tickets.avatar",
          "populate[2]": "game_variant.game",
          "populate[3]": "game_variant.game_difficulties",
          "populate[4]": "currentPlayerTurn",
          "populate[5]": "games",
          "populate[6]": "game_variant.image",
        },
        decoder: GroupCompetition.fromJson);
  }

  @override
  Future<Response<ScoreResponse>> updateScoreStatus(
      String status, int scoreId) {
    int? stationId = StationService.to.currentStation.id;

    return post<ScoreResponse>(
        'stations/$stationId/updateScoreStatus',
        {
          "CommandeId": status,
          "ScoreId": scoreId,
        },
        decoder: ScoreResponse.fromJson);
  }
}
