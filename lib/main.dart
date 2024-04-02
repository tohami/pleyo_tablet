import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/services/InactivityRedirectService.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bindings.dart';
import 'consts/colors.dart';
import 'firebase_options.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'shared/logger/logger_utils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// const BASE_URL = String.fromEnvironment('SERVER' , defaultValue: "http://admin-staging.pleyohub.com");
// const BASE_URL = String.fromEnvironment('SERVER' , defaultValue: "http://192.168.137.1:1337");
const BASE_URL = String.fromEnvironment('SERVER' , defaultValue: "http://admin.pleyohub.com");

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runZonedGuarded<Future<void>>(() async {
  runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
}

class MyApp extends StatelessWidget {

  final InactivityRedirectService _inactivityService = InactivityRedirectService(
    onTimeout: () {
      Get.rootDelegate.backUntil(Routes.MODE);
      // Your logic to navigate to the home screen goes here.
      // For example, if using a navigator key: navigatorKey.currentState?.pushNamed('/home');
    },
  );

  MyApp({Key? key}) : super(key: key){
    // _inactivityService.startListening();
    Get.put(_inactivityService);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp.router(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          minWidth: 600,
          defaultScale: true,
          defaultName: TABLET,
          breakpoints: [
            // const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            // const ResponsiveBreakpoint.autoScale(600, name: MOBILE),
            // const ResponsiveBreakpoint.autoScale(850, name: TABLET),
            // const ResponsiveBreakpoint.autoScale(1080, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ]),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBindings(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}
