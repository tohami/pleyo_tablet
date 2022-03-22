import 'package:get/get.dart';
import '../data/available_points_api_provider.dart';

import '../data/available_points_repository.dart';
import '../presentation/controllers/available_points_controller.dart';

class AvailablePointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAvailablePointsProvider>(AvailablePointsProvider());
    Get.put<IAvailablePointsRepository>(
        AvailablePointsRepository(provider: Get.find()));
    Get.put(AvailablePointsController());
  }
}
