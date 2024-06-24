import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/firebase_options.dart';
import 'package:onlinebozor/presentation/application/di/get_it_injection.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import 'data/repositories/state_repository.dart';
import 'presentation/application/application.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await Permission.notification.isDenied.then((value) {
    //   if (value) {
    //     Permission.notification.request();
    //   }
    // });

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

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
        child: Application(
          isLanguageSelected: isLanguageSelected,
          isAuthorized: isAuthorized,
        ),
      ),
    );
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white,
    //   statusBarColor: Colors.white,
    // ));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
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
