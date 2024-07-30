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
import 'package:pleyo_tablet_app/pages/mm_mode/bindings/mm_mode_binding.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/presentation/views/mm_timeline_view.dart';
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
import '../pages/multiplayer_mode/presentation/views/host_playing_view.dart';
import '../pages/multiplayer_mode/presentation/views/host_status_view.dart';
import '../pages/multiplayer_mode/presentation/views/select_game_view.dart';
import '../pages/multiplayer_mode/presentation/views/welcome_view.dart';
import '../pages/splash/bindings/splash_binding.dart';
import '../pages/splash/presentation/views/splash_view.dart';
import '../widgets/scale_widget.dart';

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
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: GameExperienceView()),
        binding: SplashBinding()),
    GetPage(
        name: Routes.GROUP_LANDING,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: SelectTeamSizeStep()),
        binding: GroupSelectStepsBinding(),
        children: [
          GetPage(
            name: Routes.GROUP_TEAM_NAME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: AddTeamNameStep()),
          ),
          GetPage(
            name: Routes.GROUP_PLAYER_NAMES,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const GroupNamesStep()),
          ),
          GetPage(
            name: Routes.GROUP_SELECT_GAME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const SelectGameStep()),
          ),
          GetPage(
            name: Routes.GROUP_SELECTED_GAME_DETAILS,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const SelectedGameDetails()),
          ),
        ]),
    GetPage(
        name: Routes.GROUP_TURN_LANDING,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: const PlayerTurn()),
        binding: GroupRotationBinding(),
        children: [
          GetPage(
            name: Routes.GROUP_TURN_GAME_STATUS,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const GameStatus()),
          ),
          GetPage(
            name: Routes.GROUP_TURN_GAME_PLAY,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const GamePlaying()),
          ),
          GetPage(
            name: Routes.GROUP_TURN_RESULT,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: FinalResult()),
          ),
        ]),
    GetPage(
        name: Routes.SINGLE_PLAY_LANDING,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: const PlayerNameStep()),
        binding: SinglePlayerModeBinding(),
        children: [
          GetPage(
            name: Routes.SINGLE_PLAY_WELCOME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const Welcome()),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_SELECT_GAME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const SelectGame()),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_GAME_STATUS,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const SingleModeGameStatus()),
          ),
          GetPage(
            name: Routes.SINGLE_PLAY_GAME_PLAY,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const SinglePlayerGamePlay()),
          ),
        ]),
    GetPage(
        name: Routes.MULTIPLAYER_LANDING,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: const MultiplayerPlayerName()),
        binding: MultiplayerModeBinding(),
        children: [
          GetPage(
            name: Routes.MULTIPLAYER_WELCOME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const MultiplayerWelcome()),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_SELECT_GAME,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const MultiplayerSelectGame()),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_HOST_GAME_STATUS,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const MultiplayerHostGameStatus()),
          ),
          GetPage(
            name: Routes.MULTIPLAYER_HOST_GAME_PLAY,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const MultiplayerHostGamePlay()),
          ),
        ]),
    GetPage(
        name: Routes.MULTIPLAYER_GUEST_GAME_STATUS,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: MultiplayerGuestGameStatus()),
        binding: MultiplayerModeBinding(),
        children: [
          GetPage(
            name: Routes.MULTIPLAYER_GUEST_GAME_PLAY,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const MultiplayerGuestGamePlay()),
          ),
        ]),
    GetPage(
      name: Routes.SCAN_QR,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: ScanQRView()),
      binding: ScanQRBinding(),
    ),
    GetPage(
      name: Routes.ACTIVATE,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const ActivateView()),
      binding: ActivateBinding(),
    ),
    GetPage(
      name: Routes.AVAILABLE_POINTS,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const AvailablePointsView()),
      binding: AvailablePointsBinding(),
    ),
    GetPage(
        name: Routes.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        children: [
          GetPage(
            name: Routes.COMPETITION_GAME_STATUS,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const CompetitionGameStatus()),
          ),
          GetPage(
            name: Routes.COMPETITION_GAME_PLAY,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const CompetitionGamePlay()),
          ),
        ]),
    GetPage(
      name: Routes.MM,
      page: () => ScaleWidget(
          builder: (context, child) => mmScaleWidgetBuilder(context, child!),
          child: MMTimeline()),
      binding: MMModeBinding(),
    ),
  ];
}
