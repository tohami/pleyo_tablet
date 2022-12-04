import 'package:get/get_connect/http/src/response/response.dart';

import '../../../base/base_provider.dart';
import '../../../model/strapi/ticket.dart';
import '../../../model/strapi/ticket_reponse.dart';

// ignore: one_member_abstracts
abstract class IActivateProvider {
  Future<Response<TicketResponse>> activateTicket(int ticketId , String secret , String nickname);
}

class ActivateProvider extends BaseProvider
    implements IActivateProvider {

  @override
  Future<Response<TicketResponse>> activateTicket(int ticketId , String secret , String nickname) {
    return put<TicketResponse>('tickets/$ticketId/activate', {
      "data" : {
        "nickname" : nickname ,
        "secret": secret ,
      }
    }, decoder: TicketResponse.fromJson);
  }
}
