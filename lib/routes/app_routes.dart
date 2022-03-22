// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const SCAN_QR = _Paths.SCAN_QR;
  static const AVAILABLE_POINTS = _Paths.AVAILABLE_POINTS;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const CUSTOM_TRIAL_TICKET = _Paths.CUSTOM_TRIAL_TICKET;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const SCAN_QR = '/scan_qr';
  static const AVAILABLE_POINTS = '/available_points';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const CUSTOM_TRIAL_TICKET = '/custom_trial';
}
