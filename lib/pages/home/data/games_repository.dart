
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import '../../../model/strapi/scores_response.dart' as lb;
import '../../../model/strapi/ticket.dart';
import 'games_api_provider.dart';

abstract class IGamesRepository {
  Future<Score> startGame(int gameDifficulty,int gameVariant,int ticketId);
  Future<Score> updateScoreStatus(String status,int scoreId, {String? reason});
  Future<lb.LeaderboardApiResponse> listScores(String competition, String game);
}

class GamesRepository extends BaseRepository
    implements IGamesRepository {
  IGamesProvider provider;

  GamesRepository({required this.provider});

  @override
  Future<Score> startGame(gameDifficulty, gameVariant, ticketId) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.startGame(gameDifficulty, gameVariant, ticketId) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
  @override
  Future<Score> updateScoreStatus(String status,int scoreId, {String? reason}) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.updateScoreStatus(status,scoreId , reason:reason) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }

  @override
  Future<lb.LeaderboardApiResponse> listScores(String competition, String game) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.listScores(competition, game) ;
    if(apiResponse.isOk && apiResponse.body != null){
      return apiResponse.body!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
}
