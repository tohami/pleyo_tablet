import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_api_provider.dart';

import '../data/tickets_repository.dart';
import '../presentation/controllers/scan_qr_controller.dart';

class ScanQRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ITicketProvider>(() => TicketProvider());
    Get.lazyPut<ITicketRepository>(
            () => TicketRepository(provider: Get.find()));
    Get.lazyPut<TicketController>(() => TicketController(repository: Get.find()));
  }
}
