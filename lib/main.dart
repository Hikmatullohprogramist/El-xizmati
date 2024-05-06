import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/display/display_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'data/repositories/state_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await Hive.initFlutter();

  await configureDependencies();

  await EasyLocalization.ensureInitialized();

  Future<void> getDeviceAndAppInfo() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var uuid = Uuid();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      DeviceInfo.appVersionName = packageInfo.version;
      DeviceInfo.appVersionCode = packageInfo.buildNumber;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        const androidId = AndroidId();
        String? deviceId = await androidId.getId();
        DeviceInfo.deviceModel = androidInfo.model;
        DeviceInfo.deviceManufacture = androidInfo.manufacturer;
        DeviceInfo.deviceName =
            "${androidInfo.manufacturer} ${androidInfo.model}";
        String combinedInfo = '$deviceId-${androidInfo.manufacturer}';
        DeviceInfo.deviceId = uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
        DeviceInfo.mobileOsType = "android";
      } else if (Platform.isIOS) {
        DeviceInfo.mobileOsType = "ios";
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String? deviceId = iosInfo.identifierForVendor;
        DeviceInfo.deviceName = iosInfo.name;
        DeviceInfo.deviceManufacture = iosInfo.systemName;
        DeviceInfo.deviceModel = iosInfo.model;
        String combinedInfo = '$deviceId-${DeviceInfo.deviceName}';
        DeviceInfo.deviceId = uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  await getDeviceAndAppInfo();

  var stateRepository = GetIt.instance<StateRepository>();
  var isLanguageSelection = await stateRepository.isLanguageSelection();
  var isUserLoggedIn = await stateRepository.isUserLoggedIn();

  runApp(
    EasyLocalization(
      supportedLocales: Strings.supportedLocales,
      path: Assets.localization.translations,
      fallbackLocale: Strings.supportedLocales.first,
      assetLoader: CsvAssetLoader(),
      child: MyApp(
        isLanguageSelection: isLanguageSelection,
        isLogin: isUserLoggedIn,
      ),
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.white,
  //   statusBarColor: Colors.white,
  // ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLanguageSelection, required this.isLogin});

  final bool isLanguageSelection;
  final bool isLogin;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.theme.brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.white : Colors.black12,
      systemNavigationBarColor: isDarkMode ? Colors.white : Colors.black12,
      statusBarIconBrightness: context.theme.brightness,
    ));
    ThemeMode themeMode = ThemeMode.system;

    return DisplayWidget(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          useMaterial3: false,
          colorScheme: _getLightModeColorScheme(),
        ),
        darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          colorScheme: _getDarkModeColorScheme(),
        ),
        themeMode: themeMode,
        routerConfig: _appRouter.config(initialRoutes: [
          if (isLanguageSelection) HomeRoute() else SetLanguageRoute()
        ], navigatorObservers: () => [ChuckerFlutter.navigatorObserver]),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }

  ColorScheme _getLightModeColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF5C6AC4),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF0096B2),
      onSecondary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFDFE2E9),
      onPrimaryContainer: Color(0xFF000000),
      secondaryContainer: Color(0xFFDFE2E9),
      onSecondaryContainer: Color(0xFF000000),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFFF2F4FB),
      onBackground: Color(0xFF000000),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
    );
  }

  ColorScheme _getDarkModeColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF5C6AC4),
      onPrimary: Color(0xFFDFE2E9),
      secondary: Color(0xFF007B92),
      onSecondary: Color(0xFFDFE2E9),
      primaryContainer: Color(0xAB121212),
      onPrimaryContainer: Color(0xFFDFE2E9),
      secondaryContainer: Color(0xFF404A80),
      onSecondaryContainer: Color(0xFFDFE2E9),
      error: Color(0xFFCF6679),
      onError: Color(0xFF000000),
      background: Color(0xFF121212),
      onBackground: Color(0xFFE0E0E0),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFE0E0E0),
    );
  }
}
