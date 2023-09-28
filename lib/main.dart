import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:superhero_app/controllers/initial_binding.dart';
import 'package:superhero_app/service/app_service/device_info_service.dart';
import 'package:superhero_app/service/app_service/localization_service.dart';
import 'package:superhero_app/utils/color.dart';
import 'package:superhero_app/utils/font.dart';
import 'package:superhero_app/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          (GetPlatform.isIOS) ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await DeviceInfoService.initialize();
  if (GetPlatform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      log(e.toString());
    }
  }

  await GetStorage.init();
  await dotenv.load(fileName: ".env.dev");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        title: "Heroes & Villains",
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('km'),
          Locale('en'),
        ],
        initialBinding: InitialBinding(),
        theme: ThemeData(
          useMaterial3: true,
          // primarySwatch: AppColors.primaryMaterialColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          fontFamily: AppFonts.primary,
          iconTheme: IconThemeData(color: AppColors.icon),
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          // primarySwatch: AppColors.primaryMaterialColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          fontFamily: AppFonts.primary,
          // iconTheme: IconThemeData(color: AppColors.icon),
          appBarTheme: AppBarTheme(
            color: AppColors.navyBlue,
            titleTextStyle: AppBarTheme.of(context)
                .titleTextStyle
                ?.copyWith(color: Colors.white),
          ),
          scaffoldBackgroundColor: AppColors.navyBlue,
        ),
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        // initialRoute: "/",
        // routes: {
        //   "/": (context) => SplashScreen(),
        // },
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
