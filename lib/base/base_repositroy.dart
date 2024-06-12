
import 'dart:convert';

import 'package:pleyo_tablet_app/model/strapi_error.dart';

class BaseRepository  {

  MapEntry<String , String> getErrorMessage(String? apiResponse) {
    if(apiResponse != null) {
      final responseJson = const JsonDecoder().convert(apiResponse);
      StrapiError errorResponse = StrapiError.fromJson(responseJson);
      if (errorResponse.error != null) {
        return MapEntry(errorResponse.error?.message??"Something went wrong ",
            errorResponse.error?.details?.error ??
                "Something went wrong please try again later");
      }
    }
    return MapEntry("Error","Something went wrong please try again later" );
  }
}
