
import 'dart:convert';

import 'package:pleyo_tablet_app/model/strapi_error.dart';

class BaseRepository  {

  MapEntry<String , String> getErrorMessage(String apiResponse) {
    final responseJson = const JsonDecoder().convert(apiResponse);
    StrapiError errorResponse = StrapiError.fromJson(responseJson);
    if(errorResponse.error != null) {
      return MapEntry( errorResponse.error!.message! , errorResponse.error!.details!.error??"Something went wrong please try again later") ;
    } else {
      return MapEntry("Error","Something went wrong please try again later" );
    }
  }
}
