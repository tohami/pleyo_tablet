import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/custom_trial_ticket/bindings/custom_trial_ticket_binding.dart';
import 'package:pleyo_tablet_app/pages/custom_trial_ticket/presentation/views/custom_trial_ticket_view.dart';
import 'package:pleyo_tablet_app/pages/generate_qr/bindings/generate_qr_binding.dart';
import 'package:pleyo_tablet_app/pages/generate_qr/presentation/views/generate_qr_view.dart';

import '../middleware/auth_middleware.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/home/presentation/views/home_view.dart';
import '../pages/login/bindings/login_binding.dart';
import '../pages/login/presentation/views/login_view.dart';
import '../pages/splash/bindings/splash_binding.dart';
import '../pages/splash/presentation/views/splash_view.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.LOGIN,
      middlewares: [EnsureNotAuthedMiddleware()],
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      middlewares: [EnsureAuthMiddleware()],
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.GENERATE_QR,
      middlewares: [EnsureAuthMiddleware()],
      page: () => const GenerateQRView(),
      binding: GenerateQRBinding(),
    ),
    GetPage(
      name: Routes.CUSTOM_TRIAL_TICKET,
      middlewares: [EnsureAuthMiddleware()],
      page: () => const CustomTrialTicketView(),
      binding: CustomTrialTicketBinding(),
    ),
  ];
}
