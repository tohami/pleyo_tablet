import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:pleyo_tablet_app/main.dart';
// import 'package:loyalty/services/auth_service.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = "$BASE_URL/api/" ;

    httpClient.timeout = Duration(minutes: 2) ;
    // httpClient.addRequestModifier<dynamic>((request) {
    //   final userInfo = AuthService.to.userInfo ;
    //   print(userInfo?.authenticationToken);
    //   request.headers.putIfAbsent("X-Authentication-Token", () => userInfo?.authenticationToken??"") ;
    //   request.headers.putIfAbsent("X-Session-Id", () => (userInfo?.sessionId?.toString()??"")) ;
    //   return request ;
    // }) ;

    httpClient.addResponseModifier((request, response) {
      printInfo(info: request.url.toString()) ;
      printInfo(info: response.bodyString!) ;
      return response ;
    });
  }
}
