import 'package:get/get.dart';

import '../presentation/controllers/group_select_steps_controller.dart';

class GroupSelectStepsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupPlayStepsController());
  }
}
