import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/pages/activate/bindings/activate_binding.dart';
import 'package:pleyo_tablet_app/pages/activate/presentation/views/activate_view.dart';
import 'package:pleyo_tablet_app/pages/available_points/bindings/available_points_binding.dart';
import 'package:pleyo_tablet_app/pages/available_points/presentation/views/available_points_view.dart';
import 'package:pleyo_tablet_app/pages/game_result/bindings/game_result_binding.dart';
import 'package:pleyo_tablet_app/pages/game_result/presentation/views/game_result_view.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/bindings/group_select_steps_binding.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/views/add_team_name_step_view.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/views/group_names_step_view.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/views/select_game_step_view.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/views/select_team_size_step_view.dart';
import 'package:pleyo_tablet_app/pages/group_play_select_steps/presentation/views/selected_game_details_view.dart';
import 'package:pleyo_tablet_app/pages/group_rotation/bindings/group_rotation_binding.dart';
import 'package:pleyo_tablet_app/pages/group_rotation/presentation/views/select_game_difficulty_view.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/bindings/scan_qr_binding.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/presentation/views/scan_qr_view.dart';
import 'package:pleyo_tablet_app/pages/splash/presentation/views/game_experiense_view.dart';

import '../middleware/auth_middleware.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/home/presentation/views/home_view.dart';
import '../pages/game_status/bindings/game_status_binding.dart';
import '../pages/game_status/presentation/views/game_status_view.dart';
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
        page: () => const GameExperienceView(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.SELECT_TEAM_SIZE,
        page: () => const SelectTeamSizeStep(),
        binding: GroupSelectStepsBinding()),
    GetPage(
        name: Routes.ADD_TEAM_NAME,
        page: () => const AddTeamNameStep(),
        binding: GroupSelectStepsBinding()),
    GetPage(
        name: Routes.GROUP_NAMES_LIST,
        page: () => const GroupNamesStep(),
        binding: GroupSelectStepsBinding()),
    GetPage(
        name: Routes.GROUP_SELECT_GAME,
        page: () => const SelectGameStep(),
        binding: GroupSelectStepsBinding()),
    GetPage(
        name: Routes.SELECTED_GAME,
        page: () => const SelectedGameDetails(),
        binding: GroupSelectStepsBinding()),
    GetPage(
        name: Routes.SELECT_GAME_DIFFICULTY,
        page: () => const SelectGameDifficulty(),
        binding: GroupRotationBinding(),
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
    ),
    GetPage(
      name: Routes.GAME_STATUS,
      page: () => GameStatusView(),
      binding: GameStatusBinding(),
    ),
    GetPage(
      name: Routes.GAME_RESULT,
      page: () => const GameResultView(),
      binding: GameResultBinding(),
    ),
  ];
}
