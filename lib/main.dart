import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

const STATION_ID = String.fromEnvironment('ID' , defaultValue: "3");

Future main() async {
  // runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Get.put(StationService());
  runApp(const MyApp());
  // }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  //
  // Isolate.current.addErrorListener(RawReceivePort((pair) async {
  //   final List<dynamic> errorAndStacktrace = pair;
  //   await FirebaseCrashlytics.instance.recordError(
  //     errorAndStacktrace.first,
  //     errorAndStacktrace.last,
  //   );
  // }).sendPort);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
