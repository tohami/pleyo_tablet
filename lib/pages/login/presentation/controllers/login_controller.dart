import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class LoginController extends SuperController<bool> {
  LoginController();

  TextEditingController userNameController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;

  RxBool isValidUserName = false.obs;
  RxBool isValidPassword = false.obs;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
    userNameController.addListener(() {
      isValidUserName.value = userNameController.text.isNotEmpty ;
      update() ;
    }) ;

    passwordController.addListener(() {
      isValidPassword.value = passwordController.text.isNotEmpty ;
      update() ;
    }) ;
  }

  onLoginClicked() async {
    try {
      change(false, status: RxStatus.loading());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userNameController.text, password: passwordController.text);
      Get.rootDelegate.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for this email");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password provided for that user.");
      }
    } finally {
      change(false, status: RxStatus.success());
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
