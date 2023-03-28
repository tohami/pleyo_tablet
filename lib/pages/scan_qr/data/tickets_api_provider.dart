import 'package:get/get.dart';
import 'package:pleyo_tablet_app/base/base_provider.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';

abstract class ITicketProvider {
  Future<Response<TicketResponse>> checkTicket(String id , String secret);
}

class TicketProvider extends BaseProvider
    implements ITicketProvider {
  @override
  Future<Response<TicketResponse>> checkTicket(String id , String secret) {
    // TODO: implement getAllMerchantsr
    return post<TicketResponse>('stations/$STATION_ID/checkTicket', {
      "data" : {
        "id" : id ,
        "secret": secret ,
      }
    }, decoder: TicketResponse.fromJson);
  }
}
