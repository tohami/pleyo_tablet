// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const SELECT_TEAM_SIZE = _Paths.SELECT_TEAM_SIZE;
  static const ADD_TEAM_NAME = _Paths.ADD_TEAM_NAME;
  static const GROUP_NAMES_LIST = _Paths.GROUP_NAMES_LIST;
  static const GROUP_SELECT_GAME = _Paths.GROUP_SELECT_GAME;
  static const SELECTED_GAME = _Paths.SELECTED_GAME;
  static const SELECT_GAME_DIFFICULTY = _Paths.SELECT_GAME_DIFFICULTY;
  static const START_GAME = _Paths.START_GAME;
  static const REMAKE_PLAYING = _Paths.REMAKE_PLAYING;
  static const FINAL_RESULT = _Paths.FINAL_RESULT;
  static const SCAN_QR = _Paths.SCAN_QR;
  static const ACTIVATE = _Paths.ACTIVATE;
  static const AVAILABLE_POINTS = _Paths.AVAILABLE_POINTS;
  static const HOME = _Paths.HOME;
  static const GAME_STATUS = _Paths.GAME_STATUS;
  static const GAME_RESULT = _Paths.GAME_RESULT;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const SELECT_TEAM_SIZE = '/select_team_size';
  static const ADD_TEAM_NAME = '/add_team_name';
  static const GROUP_NAMES_LIST = '/group_name_list';
  static const GROUP_SELECT_GAME = '/group_select_game';
  static const SELECTED_GAME = '/selected_game';
  static const SELECT_GAME_DIFFICULTY = '/select_game_difficulty';
  static const START_GAME = '/start_game';
  static const REMAKE_PLAYING = '/remake_playing';
  static const FINAL_RESULT = '/final_result';
  static const SCAN_QR = '/scan_qr';
  static const ACTIVATE = '/activate';
  static const AVAILABLE_POINTS = '/available_points';
  static const HOME = '/home';
  static const GAME_STATUS = '/game_status';
  static const GAME_RESULT = '/game_result';
}
