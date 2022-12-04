
import 'dart:convert';

import 'package:pleyo_tablet_app/model/strapi_error.dart';

class BaseRepository  {

  String getErrorMessage(String apiResponse) {
    final responseJson = const JsonDecoder().convert(apiResponse);
    StrapiError errorResponse = StrapiError.fromJson(responseJson);
    if(errorResponse.error != null) {
      return errorResponse.error!.message! ;
    } else {
      return "Something went wrong please try again later" ;
    }
  }
}
