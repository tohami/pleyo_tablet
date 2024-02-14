import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/data/group_repository.dart';

import '../data/group_api_provider.dart';
import '../presentation/controllers/group_select_steps_controller.dart';

class GroupSelectStepsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGroupsProvider>(() => GroupsProvider());
    Get.lazyPut<IGroupsRepository>(
            () => GroupsRepository(provider: Get.find()));
    Get.lazyPut(() => GroupPlayStepsController(Get.find()));
  }
}
