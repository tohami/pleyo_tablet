import 'package:pleyo_tablet_app/model/strapi/ticket.dart';

import '../../../base/base_repositroy.dart';
import 'activate_api_provider.dart';

abstract class IActivateRepository {
  Future<Ticket> activateTicket(int ticketId , String secret , String nickname, Map<String, String> activationExtras);
}
class ActivateRepository extends BaseRepository
    implements IActivateRepository {
  IActivateProvider provider;

  ActivateRepository({required this.provider});

  @override
  Future<Ticket> activateTicket(int ticketId , String secret , String nickname , Map<String, String> activationExtras) async{
    // TODO: implement getAllMerchants
    final apiResponse = await provider.activateTicket(ticketId, secret , nickname , activationExtras) ;
    if(apiResponse.isOk && apiResponse.body?.data != null){
      return apiResponse.body!.data!;
    }else {
      throw(getErrorMessage(apiResponse.bodyString!)) ;
    }
  }
}
