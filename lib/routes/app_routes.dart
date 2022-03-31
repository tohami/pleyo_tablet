// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const SCAN_QR = _Paths.SCAN_QR;
  static const AVAILABLE_POINTS = _Paths.AVAILABLE_POINTS;
  static const HOME = _Paths.HOME;
  static const GAME_STATUS = _Paths.GAME_STATUS;
  static const GAME_RESULT = _Paths.GAME_RESULT;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const SCAN_QR = '/scan_qr';
  static const AVAILABLE_POINTS = '/available_points';
  static const HOME = '/home';
  static const GAME_STATUS = '/game_status';
  static const GAME_RESULT = '/game_result';
}
