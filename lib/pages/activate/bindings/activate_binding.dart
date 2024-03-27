import 'package:get/get.dart';
import '../data/activate_api_provider.dart';

import '../data/activate_repository.dart';
import '../presentation/controllers/activate_controller.dart';

class ActivateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IActivateProvider>(ActivateProvider());
    Get.put<IActivateRepository>(
        ActivateRepository(provider: Get.find()));
    Get.put(ActivateController(repository: Get.find()));
  }
}
