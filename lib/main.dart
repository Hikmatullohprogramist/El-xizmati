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
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/display/display_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'domain/repository/state_repository.dart';

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

      DeviceInfo.app_version_name = packageInfo.version;
      DeviceInfo.app_version_code = packageInfo.buildNumber;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        const androidId = AndroidId();
        String? deviceId = await androidId.getId();
        DeviceInfo.device_model = androidInfo.model;
        DeviceInfo.device_manufacture = androidInfo.manufacturer;
        DeviceInfo.device_name =
            "${androidInfo.manufacturer} ${androidInfo.model}";
        String combinedInfo = '$deviceId-${androidInfo.manufacturer}';
        DeviceInfo.device_id = uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
        DeviceInfo.mobile_os_type = "android";
      } else if (Platform.isIOS) {
        DeviceInfo.mobile_os_type="ios";
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String? deviceId = iosInfo.identifierForVendor;
        DeviceInfo.device_name = iosInfo.name;
        DeviceInfo.device_manufacture = iosInfo.systemName;
        DeviceInfo.device_model = iosInfo.model;
        String combinedInfo = '$deviceId-${DeviceInfo.device_name}';
        DeviceInfo.device_id = uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  await getDeviceAndAppInfo();

  var stateRepository = GetIt.instance<StateRepository>();
  var isLanguageSelection =
      await stateRepository.isLanguageSelection() ?? false;
  var isLogin = await stateRepository.isLogin() ?? false;

  runApp(
    EasyLocalization(
      supportedLocales: Strings.supportedLocales,
      path: Assets.localization.translations,
      fallbackLocale: Strings.supportedLocales.first,
      assetLoader: CsvAssetLoader(),
      child: MyApp(
        isLanguageSelection: isLanguageSelection,
        isLogin: isLogin,
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLanguageSelection, required this.isLogin});

  final bool isLanguageSelection;
  final bool isLogin;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return DisplayWidget(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        routerConfig: _appRouter.config(initialRoutes: [
          if (isLanguageSelection)
            if (isLogin) HomeRoute() else HomeRoute()
          else
            SetLanguageRoute()
        ], navigatorObservers: () => [ChuckerFlutter.navigatorObserver]),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
