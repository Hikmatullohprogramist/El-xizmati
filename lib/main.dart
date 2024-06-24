import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/firebase_options.dart';
import 'package:onlinebozor/presentation/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_manager.dart';
import 'package:onlinebozor/presentation/support/state_message/state_snack_bar_exts.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import 'data/repositories/state_repository.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });

  await initializeGetIt();

  await EasyLocalization.ensureInitialized();

  await _getDeviceAndAppInfo();

  var stateRepository = GetIt.instance<StateRepository>();
  var isLanguageSelected = stateRepository.isLanguageSelected();
  var isAuthorized = stateRepository.isAuthorized();

  runApp(
    EasyLocalization(
      supportedLocales: Strings.supportedLocales,
      path: Assets.localization.translations,
      fallbackLocale: Strings.supportedLocales.first,
      assetLoader: CsvAssetLoader(),
      child: MyApp(
        isLanguageSelected: isLanguageSelected,
        isAuthorized: isAuthorized,
      ),
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.white,
  //   statusBarColor: Colors.white,
  // ));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.isLanguageSelected,
    required this.isAuthorized,
  });

  final bool isLanguageSelected;
  final bool isAuthorized;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    ThemeMode themeMode = ThemeMode.system;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Inter',
              useMaterial3: false,
              colorScheme: _getLightModeColorScheme(),
            ),
            darkTheme: ThemeData(
              fontFamily: 'Inter',
              useMaterial3: false,
              brightness: Brightness.dark,
              colorScheme: _getDarkModeColorScheme(),
            ),
            themeMode: themeMode,
            routerConfig: _appRouter.config(
              initialRoutes: [
                if (isLanguageSelected) HomeRoute() else SetLanguageRoute()
              ],
              navigatorObservers: () => [ChuckerFlutter.navigatorObserver],
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
          Builder(
            builder: (context) {
              // _initStateMessageManager(context);

              final stateMessageManager = getIt<StateMessageManager>();

              stateMessageManager.setListeners(
                onShowBottomSheet: (m) =>
                    showStateMessageBottomSheet(context, m),
                onShowSnackBar: (m) => context.showStateMessageSnackBar(m),
              );

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _initStateMessageManager(BuildContext context) {
    final stateMessageManager = getIt<StateMessageManager>();

    stateMessageManager.setListeners(
      onShowBottomSheet: (m) => showStateMessageBottomSheet(context, m),
      onShowSnackBar: (m) => context.showStateMessageSnackBar(m),
    );
  }

  ColorScheme _getLightModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
      primary: Color(0xFF5C6AC4),
      secondary: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF000000),
      surface: Color(0xFFF3F3F3),
      onSurface: Color(0xFF000000),
    );
    // return ColorScheme(
    //   brightness: Brightness.light,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFFFFFFF),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFFFFFFFF),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xFFDFE2E9),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFFB3E5FC),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFB00020),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFFFFFFFF),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFFFFFFFF),
    //   // General background color for the app
    //   onBackground: Color(0xFF000000),
    //   // Color used for text/icons on background
    //   surface: Color(0xFFF3F3F3),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFF000000),
    //   // Color used for text/icons on surfaces
    // );
  }

  ColorScheme _getDarkModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: Color(0xFF5C6AC4),
      secondary: Color(0xFF000000),
      background: Color(0xFF121212),
      onBackground: Color(0xFFE0E0E0),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFE0E0E0),
    );
    // return ColorScheme(
    //   brightness: Brightness.dark,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFF000000),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xAB121212),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFF404A80),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFCF6679),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFF000000),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFF121212),
    //   // General background color for the app
    //   onBackground: Color(0xFFE0E0E0),
    //   // Color used for text/icons on background
    //   surface: Color(0xFF333333),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFFE0E0E0),
    //   // Color used for text/icons on surfaces
    // );
  }

  void showStateMessageBottomSheet(BuildContext context, StateMessage message) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          color: context.bottomSheetColor,
          child: Container(
            color: context.bottomSheetColor,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Center(child: message.titleOrDefault.s(22).w(600)),
                SizedBox(height: 14),
                message.message.s(16).w(500).copyWith(
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                SizedBox(height: 32),
                CustomElevatedButton(
                  text: Strings.closeTitle,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(buildContext);
                  },
                  backgroundColor: context.colors.buttonPrimary,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> _getDeviceAndAppInfo() async {
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
