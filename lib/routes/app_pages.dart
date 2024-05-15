import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/activate/bindings/activate_binding.dart';
import 'package:pleyo_tablet_app/pages/activate/presentation/views/activate_view.dart';
import 'package:pleyo_tablet_app/pages/available_points/bindings/available_points_binding.dart';
import 'package:pleyo_tablet_app/pages/available_points/presentation/views/available_points_view.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/bindings/group_select_steps_binding.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/views/add_team_name_step_view.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/views/group_names_step_view.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/views/select_game_step_view.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/views/select_team_size_step_view.dart';
import 'package:pleyo_tablet_app/pages/create_group_competition/presentation/views/selected_game_details_view.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/bindings/multiplayer_mode_binding.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/views/guest_playing_view.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/views/guest_status_view.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/views/player_name_view.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/views/competition_game_playing.dart';
import 'package:pleyo_tablet_app/pages/home/presentation/views/competition_game_status_view.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/bindings/single_player_mode_binding.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/views/game_playing_view.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/views/game_status_view.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/views/player_name_view.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/views/select_game_view.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/presentation/views/welcome_view.dart';
import 'package:pleyo_tablet_app/pages/turn_management/bindings/group_rotation_binding.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/views/final_result_view.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/views/game_playing_view.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/views/player_turn_view.dart';
import 'package:pleyo_tablet_app/pages/turn_management/presentation/views/game_status_view.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/bindings/scan_qr_binding.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/presentation/views/scan_qr_view.dart';
import 'package:pleyo_tablet_app/pages/splash/presentation/views/game_experiense_view.dart';

import '../pages/home/bindings/home_binding.dart';
import '../pages/home/presentation/views/home_view.dart';
import '../pages/game_status/bindings/game_status_binding.dart';
import '../pages/game_status/presentation/views/game_status_view.dart';
import '../pages/multiplayer_mode/presentation/views/host_playing_view.dart';
import '../pages/multiplayer_mode/presentation/views/host_status_view.dart';
import '../pages/multiplayer_mode/presentation/views/select_game_view.dart';
import '../pages/multiplayer_mode/presentation/views/welcome_view.dart';
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
        name: Routes.MODE,
        page: () => const GameExperienceView(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.GROUP_LANDING,
        page: () => SelectTeamSizeStep(),
        binding: GroupSelectStepsBinding(),
        children: [
          GetPage(
            name: Routes.GROUP_TEAM_NAME,
            page: () => const AddTeamNameStep(),
          ),
          GetPage(
            name: Routes.GROUP_PLAYER_NAMES,
            page: () => const GroupNamesStep(),
          ),
          GetPage(
            name: Routes.GROUP_SELECT_GAME,
            page: () => const SelectGameStep(),
          ),
          GetPage(
            name: Routes.GROUP_SELECTED_GAME_DETAILS,
            page: () => const SelectedGameDetails(),
          ),
        ]),
    GetPage(
        name: Routes.GROUP_TURN_LANDING,
        page: () => const PlayerTurn(),
        binding: GroupRotationBinding(),
        children: [
          GetPage(
            name: Routes.GROUP_TURN_GAME_STATUS,
            page: () => const GameStatus(),
          ),
          GetPage(
            name: Routes.GROUP_TURN_GAME_PLAY,
            page: () => const GamePlaying(),
          ),
          GetPage(
            name: Routes.GROUP_TURN_RESULT,
            page: () => FinalResult(),
          ),
        ]),
    GetPage(
        name: Routes.SINGLE_PLAY_LANDING,
        page: () => const PlayerNameStep(),
        binding: SinglePlayerModeBinding(),
        children: [
          GetPage(
            name: Routes.SINGLE_PLAY_WELCOME,
            page: () => const Welcome(),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_SELECT_GAME,
            page: () => const SelectGame(),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_GAME_STATUS,
            page: () => const SingleModeGameStatus(),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_GAME_PLAY,
            page: () => const SinglePlayerGamePlay(),
          ),
        ]),
    GetPage(
        name: Routes.MULTIPLAYER_LANDING,
        page: () => const MultiplayerPlayerName(),
        binding: MultiplayerModeBinding(),
        children: [
          GetPage(
            name: Routes.MULTIPLAYER_WELCOME,
            page: () => const MultiplayerWelcome(),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_SELECT_GAME,
            page: () => const MultiplayerSelectGame(),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_HOST_GAME_STATUS,
            page: () => const MultiplayerHostGameStatus(),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_HOST_GAME_PLAY,
            page: () => const MultiplayerHostGamePlay(),
          ),
        ]),
    GetPage(
        name: Routes.MULTIPLAYER_GUEST_GAME_STATUS,
        page: () => MultiplayerGuestGameStatus(),
      children: [
        GetPage(
          name: Routes.MULTIPLAYER_GUEST_GAME_PLAY,
          page: () => const MultiplayerGuestGamePlay(),
        ),
      ]
    ),
    GetPage(
      name: Routes.SCAN_QR,
      page: () => ScanQRView(),
      binding: ScanQRBinding(),
    ),
    GetPage(
      name: Routes.ACTIVATE,
      page: () => const ActivateView(),
      binding: ActivateBinding(),
    ),
    GetPage(
      name: Routes.AVAILABLE_POINTS,
      page: () => const AvailablePointsView(),
      binding: AvailablePointsBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: Routes.COMPETITION_GAME_STATUS,
          page: () => const CompetitionGameStatus(),
        ),
        GetPage(
          name: Routes.COMPETITION_GAME_PLAY,
          page: () => const CompetitionGamePlay(),
        ),
      ]
    )
  ];
}
