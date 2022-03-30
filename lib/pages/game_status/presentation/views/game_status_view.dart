import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_status_controller.dart';

class GameStatusView extends GetView<GameStatusController> {
  GameStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(),
        ),
      ),
    );
  }
}
