import 'package:pleyo_tablet_app/model/strapi/personas.dart';
import 'package:pleyo_tablet_app/model/strapi/station.dart';

import '../../../base/base_repositroy.dart';
import '../../../model/strapi/ticket_reponse.dart';
import 'splash_api_provider.dart';

abstract class ISplashRepository {
  Future<Station> findOrCreateStation(serial);
  Future<List<PersonaGroupData>> getPersonas() ;
}

class SplashRepository extends BaseRepository implements ISplashRepository {
  SplashRepository({required this.provider});

  final ISplashProvider provider;

  @override
  Future<Station> findOrCreateStation(serial) async {
    // TODO: implement getAllMerchants
    final apiResponse = await provider.findOrCreateStation(serial);
    if (apiResponse.isOk && apiResponse.body?.data != null) {
      return apiResponse.body!.data!;
    } else {
      throw AssertionError(getErrorMessage(apiResponse.bodyString));
    }
  }

  @override
  Future<List<PersonaGroupData>> getPersonas() async {
    // TODO: implement getAllMerchants
    final apiResponse = await provider.getPersonas();
    if (apiResponse.isOk && apiResponse.body?.data != null) {
      return apiResponse.body!.data!;
    } else {
      throw AssertionError(getErrorMessage(apiResponse.bodyString));
    }
  }
}
