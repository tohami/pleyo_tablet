import 'package:get/get.dart';

import '../presentation/controllers/custom_trial_ticket_controller.dart';

class CustomTrialTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomTrialTicketController());
  }
}
