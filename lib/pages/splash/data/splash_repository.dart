import 'package:pleyo_tablet_app/model/strapi/station.dart';

import '../../../base/base_repositroy.dart';
import '../../../model/strapi/ticket_reponse.dart';
import 'splash_api_provider.dart';

abstract class ISplashRepository {
  Future<Station> getStationData();

}

class SplashRepository extends BaseRepository implements ISplashRepository {
  SplashRepository({required this.provider});
  final ISplashProvider provider;

  Future<Station> getStationData() async{
  // TODO: implement getAllMerchants
  final apiResponse = await provider.getStationData() ;
  if(apiResponse.isOk && apiResponse.body?.data != null){
  return apiResponse.body!.data!;
  }else {
  throw(getErrorMessage(apiResponse.bodyString!)) ;
  }
}
}
