import 'package:get/get.dart';

import '../presentation/controllers/scan_qr_controller.dart';

class ScanQRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanQRController());
  }
}
