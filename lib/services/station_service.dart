import 'package:get/get.dart';

import '../model/strapi/station.dart';
import '../model/strapi/ticket.dart';

class StationService extends GetxService {
  static StationService get to => Get.find();

  late Ticket currentTicket ;
  late Station currentStation ;

  @override
  void onInit() {
    super.onInit();
  }
}