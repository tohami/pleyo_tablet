import 'package:get/get.dart';

import '../presentation/controllers/generate_qr_controller.dart';

class GenerateQRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateQRController());
  }
}
