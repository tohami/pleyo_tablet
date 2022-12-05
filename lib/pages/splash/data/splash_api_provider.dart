import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:pleyo_tablet_app/model/strapi/station_response.dart';
import '../../../base/base_provider.dart';
import '../../../main.dart';
import '../../../model/strapi/ticket_reponse.dart';

// ignore: one_member_abstracts
abstract class ISplashProvider {
  Future<Response<StationResponse>> getStationData();
}

class SplashProvider extends BaseProvider
    implements ISplashProvider {

  @override
  Future<Response<StationResponse>> getStationData() {

    return get<StationResponse>('stations/$STATION_ID',query: {
      "populate" : ["organization" ,"game_variants" ,"game_variants.game"  , "game_variants.game_difficulties" , "game_variants.image" ],
    }, decoder: StationResponse.fromJson);
  }
}
