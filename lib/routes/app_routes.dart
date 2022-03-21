// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const GENERATE_QR = _Paths.GENERATE_QR;
  static const CUSTOM_TRIAL_TICKET = _Paths.CUSTOM_TRIAL_TICKET;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const GENERATE_QR = '/generate_qr';
  static const CUSTOM_TRIAL_TICKET = '/custom_trial';
}
