import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

abstract class ITicketProvider {
  Future<Response<TicketResponse>> checkTicket(String id , String secret);
}

class TicketProvider extends BaseProvider
    implements ITicketProvider {
  @override
  Future<Response<TicketResponse>> checkTicket(String id , String secret) {
    int? stationId = StationService.to.currentStation.id ;
    return post<TicketResponse>('stations/$stationId/checkTicket', {
      "data" : {
        "id" : id ,
        "secret": secret ,
      }
    }, decoder: TicketResponse.fromJson);
  }
}
