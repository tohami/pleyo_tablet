
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart' as gc;
import 'package:pleyo_tablet_app/model/strapi/score_response.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_api_provider.dart';
import '../../../model/strapi/ticket.dart';
import 'games_api_provider.dart';

abstract class IGamesRepository {
  Future<Score> startGame(int gameDifficulty,int gameVariant,int ticketId);
  Future<Score> updateScoreStatus(String status,int scoreId);
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
  Future<Score> updateScoreStatus(String status,int scoreId) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.updateScoreStatus(status,scoreId) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
}
