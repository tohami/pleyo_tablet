import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/data/mm_api_provider.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/data/mm_repository.dart';

import '../presentation/controllers/mm_controller.dart';


class MMModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMMProvider>(() => MMProvider());
    Get.lazyPut<IMMRepository>(() => MMRepository(provider: Get.find()));

    Get.lazyPut(() => MMController(mmRepository: Get.find()));
  }
}
