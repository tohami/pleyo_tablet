import 'package:get/get.dart';

import '../../scan_qr/data/tickets_api_provider.dart';
import '../../scan_qr/data/tickets_repository.dart';
import '../../scan_qr/presentation/controllers/scan_qr_controller.dart';
import '../data/games_api_provider.dart';
import '../data/games_repository.dart';
import '../presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGamesProvider>(() => GamesProvider());
    Get.lazyPut<IGamesRepository>(
            () => GamesRepository(provider: Get.find()));
    Get.lazyPut(() => HomeController(repository: Get.find()));
  }
}
