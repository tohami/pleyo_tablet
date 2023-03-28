
import 'package:pleyo_tablet_app/base/base_repositroy.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket_reponse.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_api_provider.dart';
import '../../../model/strapi/ticket.dart';

abstract class ITicketRepository {
  Future<Ticket> checkTicket(String id , String secret);
}

class TicketRepository extends BaseRepository
    implements ITicketRepository {
  ITicketProvider provider;

  TicketRepository({required this.provider});

  @override
  Future<Ticket> checkTicket(String id , String secret) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.checkTicket(id, secret) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
}
