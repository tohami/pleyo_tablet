import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import '../../../../consts/text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_button_container.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_field_container.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 780,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomText(
                  'Login',
                  textStyle: TextStyles.textXLarge,
                ),
                CustomTextFieldContainer(
                  "Username",
                  inputContainer(
                    CustomTextFormField(
                      obscureText: false,
                      controller: controller.userNameController,
                      suffix: ObxValue<RxBool>((state) {
                        return state.value
                            ? const Icon(
                                Icons.check,
                                size: 36,
                                color: Colors.black,
                              )
                            : Container();
                      }, controller.isValidUserName),
                    ),
                  ),
                ),
                CustomTextFieldContainer(
                  "Password",
                  inputContainer(
                    CustomTextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      suffix: ObxValue<RxBool>((state) {
                        return state.value
                            ? const Icon(
                                Icons.check,
                                size: 36,
                                color: Colors.black,
                              )
                            : Container();
                      }, controller.isValidPassword),
                    ),
                  ),
                ),
                controller.obx((state) {
                  return CustomButtonContainer(
                      CustomButton(
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                        () {
                          if(controller.isValidPassword.value &&
                              controller.isValidUserName.value) {
                            controller.onLoginClicked();
                          }
                        },
                        backGroundColor: controller.isValidPassword.value &&
                                controller.isValidUserName.value
                            ? Colors.black
                            : const Color(ColorCode.grayBackground),
                        key: const ValueKey("loginBtn"),
                        borderRadius: 2,
                      ),
                      width: 327,
                      height: 48);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFE6E6E6),
        border: Border.all(
          width: 2.0,
          color: const Color(0xFF808080),
        ),
      ),
      child: child,
    );
  }
}

// class Web192010 extends StatelessWidget {
//   const Web192010({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           width: 780.0,
//           height: 1080.0,
//           child: Column(
//             children: <Widget>[
//               Spacer(flex: 138),
//               Text(
//                 'Login',
//                 style: TextStyle(
//                   fontFamily: 'Arial',
//                   fontSize: 60.0,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Spacer(flex: 100),
// // Group: Username text field
//
//               SizedBox(
//                 width: 780.0,
//                 height: 162.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Username',
//                         style: TextStyle(
//                           fontFamily: 'Arial',
//                           fontSize: 30.0,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 780.0,
//                       height: 110.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: const Color(0xFFE6E6E6),
//                         border: Border.all(
//                           width: 2.0,
//                           color: const Color(0xFF808080),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(flex: 106),
// // Group: Password text field
//
//               SizedBox(
//                 width: 780.0,
//                 height: 162.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Password',
//                         style: TextStyle(
//                           fontFamily: 'Arial',
//                           fontSize: 30.0,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 780.0,
//                       height: 109.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: const Color(0xFFE6E6E6),
//                         border: Border.all(
//                           width: 2.0,
//                           color: const Color(0xFF808080),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(flex: 160),
// // Group: Button
//               Container(
//                 alignment: Alignment.center,
//                 width: 327.0,
//                 height: 48.0,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4.0),
//                   color: Colors.black.withOpacity(0.3),
//                 ),
//                 child: SvgPicture.string(
//                   // Arrow right icon 16x16
//                   '<svg viewBox="0.0 0.0 16.0 16.0" ><path  d="M 8 0 L 6.545454978942871 1.454545497894287 L 12.05194854736328 6.961039066314697 L 0 6.961039066314697 L 0 9.038961410522461 L 12.05194854736328 9.038961410522461 L 6.545454978942871 14.54545497894287 L 8 16 L 16 8 L 8 0 Z" fill="#e6e6e6" fill-opacity="0.3" stroke="none" stroke-width="1" stroke-opacity="0.3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 16.0,
//                   height: 16.0,
//                 ),
//               ),
//               Spacer(flex: 137),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
