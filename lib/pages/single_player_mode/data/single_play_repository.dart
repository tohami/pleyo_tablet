
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import '../../../model/strapi/ticket.dart';
import 'single_play_api_provider.dart';

abstract class ISinglePlayRepository {
  Future<Ticket> createSinglePlayTicket(int stationId, TicketAttributes data);
}

class SinglePlayRepository extends BaseRepository
    implements ISinglePlayRepository {
  ISinglePlayProvider provider;

  SinglePlayRepository({required this.provider});



  Future<Ticket> createSinglePlayTicket(int stationId, TicketAttributes data) async {
      // TODO: implement getAllMerchants
      final apiResponse = await provider.createSinglePlayTicket(stationId, data) ;
      if(apiResponse.isOk && apiResponse.body?.data != null){
        return apiResponse.body!.data!;
      }else {
        throw(getErrorMessage(apiResponse.bodyString!)) ;
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
