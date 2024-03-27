import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';


abstract class ISinglePlayProvider {
  Future<Response<TicketResponse>> createSinglePlayTicket(int stationId, TicketAttributes data);

}

class SinglePlayProvider extends BaseProvider implements ISinglePlayProvider {
  @override
  Future<Response<TicketResponse>> createSinglePlayTicket(int stationId, TicketAttributes data){

    return post<TicketResponse>(
        'stations/$stationId/createSinglePlayerTicket', {
          "data" : data.toJson()
    }, decoder: TicketResponse.fromJson);
  }
}
