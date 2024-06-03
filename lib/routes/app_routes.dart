// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {

  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const MODE = _Paths.MODE;
  static const GROUP_LANDING = _Paths.SELECT_TEAM_SIZE;
  static const GROUP_TEAM_NAME = _Paths.ADD_TEAM_NAME;
  static const GROUP_PLAYER_NAMES = _Paths.GROUP_NAMES_LIST;
  static const GROUP_SELECT_GAME = _Paths.GROUP_SELECT_GAME;
  static const GROUP_SELECTED_GAME_DETAILS = _Paths.SELECTED_GAME;
  static const GROUP_TURN_LANDING = _Paths.SELECT_GAME_DIFFICULTY;
  static const GROUP_TURN_GAME_STATUS = _Paths.START_GAME;
  static const GROUP_TURN_GAME_PLAY = _Paths.REMAKE_PLAYING;
  static const GROUP_TURN_RESULT = _Paths.FINAL_RESULT;
  static const SINGLE_PLAY_LANDING = _Paths.ADD_PLAYER_NAME;
  static const SINGLE_PLAY_WELCOME = _Paths.WELCOME;
  static const SINGLE_PLAY_SELECT_GAME = _Paths.SINGLE_MODE_SELECT_GAME;
  static const SINGLE_PLAY_GAME_STATUS = _Paths.SINGLE_MODE_GAME_STATUS;
  static const SINGLE_PLAY_GAME_PLAY = _Paths.SINGLE_PLAY_GAME_PLAY;
  static const MULTIPLAYER_LANDING = _Paths.MULTIPLAYER_PLAYER_NAME;
  static const MULTIPLAYER_WELCOME = _Paths.MULTIPLAYER_WELCOME;
  static const MULTIPLAYER_SELECT_GAME = _Paths.MULTIPLAYER_SELECT_GAME;
  static const MULTIPLAYER_HOST_GAME_STATUS = _Paths.MULTIPLAYER_HOST_GAME_STATUS;
  static const MULTIPLAYER_HOST_GAME_PLAY = _Paths.MULTIPLAYER_HOST_GAME_PLAY;
  static const MULTIPLAYER_GUEST_GAME_STATUS = _Paths.MULTIPLAYER_GUEST_GAME_STATUS;
  static const MULTIPLAYER_GUEST_GAME_PLAY = _Paths.MULTIPLAYER_GUEST_GAME_PLAY;
  static const SCAN_QR = _Paths.SCAN_QR;
  static const ACTIVATE = _Paths.ACTIVATE;
  static const AVAILABLE_POINTS = _Paths.AVAILABLE_POINTS;
  static const HOME = _Paths.HOME;
  static const COMPETITION_GAME_PLAY = _Paths.COMPETITION_GAME_PLAY;
  static const COMPETITION_GAME_STATUS = _Paths.COMPETITION_GAME_STATUS;
  static const MM = _Paths.MM;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const MODE = '/mode';
  static const SELECT_TEAM_SIZE = '/select_team_size';
  static const ADD_TEAM_NAME = '/add_team_name';
  static const GROUP_NAMES_LIST = '/group_name_list';
  static const GROUP_SELECT_GAME = '/group_select_game';
  static const SELECTED_GAME = '/selected_game';
  static const SELECT_GAME_DIFFICULTY = '/select_game_difficulty';
  static const START_GAME = '/start_game';
  static const REMAKE_PLAYING = '/remake_playing';
  static const FINAL_RESULT = '/final_result';
  static const ADD_PLAYER_NAME = '/add_player_name';
  static const WELCOME = '/welcome';
  static const SINGLE_MODE_SELECT_GAME = '/single_mode_select_game';
  static const SINGLE_MODE_GAME_STATUS = '/single_mode_game_status';
  static const MULTIPLAYER_PLAYER_NAME = '/multiplayer_player_name';
  static const MULTIPLAYER_WELCOME = '/multiplayer_welcome';
  static const MULTIPLAYER_SELECT_GAME = '/multiplayer_select_game';
  static const MULTIPLAYER_HOST_GAME_STATUS = '/multiplayer_host_game_status';
  static const MULTIPLAYER_HOST_GAME_PLAY = '/multiplayer_host_game_play';
  static const MULTIPLAYER_GUEST_GAME_STATUS = '/multiplayer_guest_game_status';
  static const MULTIPLAYER_GUEST_GAME_PLAY = '/multiplayer_guest_game_play';

  static const SCAN_QR = '/scan_qr';
  static const ACTIVATE = '/activate';
  static const AVAILABLE_POINTS = '/available_points';
  static const HOME = '/home';
  static const COMPETITION_GAME_STATUS = '/competition_game_status';
  static const COMPETITION_GAME_PLAY = '/competition_game_play';

  static const SINGLE_PLAY_GAME_PLAY = '/single_play_game_play';
  static const MM = '/MM';
}
