import 'package:get/get.dart';

import '../presentation/controllers/group_rotation_controller.dart';

class GroupRotationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupRotationController());
  }
}
