import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/domain/model/auth_interceptor/auth_interceptor.dart';
import 'package:onlinebozor/domain/model/intercepter/language_intercepter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/model/intercepter/app_intercepter.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor,
      LanguageInterceptor languageInterceptor, AppInterceptor appInterceptor) {
    final options = BaseOptions(baseUrl: Constants.baseUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final dio = Dio(options);
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(languageInterceptor);
    dio.interceptors.add(appInterceptor);
    dio.interceptors.add(_loggerInterceptor);
    dio.interceptors.add(_headerInterceptor);
    return dio;
  }

  PrettyDioLogger get _loggerInterceptor => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      );

  Interceptor get _headerInterceptor => InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) {
          options.headers.addAll(_basicAuthHeaders);
          handler.next(options);
        },
      );

  Map<String, String> get _basicAuthHeaders {
    final headers = <String, String>{};

    return headers;
  }
}
// "App-Version-Code": "122",
// "App-Version-Name": "1232",

// "Device-Id": "00000000-0000-0028-ffff-ffff95b0417a",
// "Device-Name": "Google Pixel 6 Pro",
// "Device-Manufacturer": "Google",
// "Device-Model": "Pixel 6 Pro",
// "Mobile-Os-Version": "33",
// "Mobile-Os-Type": "android",
// "User-Agent":
// "00000000-0000-0028-ffff-ffff95b0417a&&Google Pixel 6 Pro&&Google&&Pixel 6 Pro&&",
// "Night-Mode": "disabled",
// "Mobile-Os": "33"

// "App-Version-Code": "122",
// "App-Version-Name": "1232",

// "Device-Id": "00000000-0000-0028-ffff-ffff95b0417a",
// "Device-Name": "Google Pixel 6 Pro",
// "Device-Manufacturer": "Google",
// "Device-Model": "Pixel 6 Pro",
// "Mobile-Os-Version": "33",
// "Mobile-Os-Type": "android",
// "User-Agent":
// "00000000-0000-0028-ffff-ffff95b0417a&&Google Pixel 6 Pro&&Google&&Pixel 6 Pro&&",
// "Night-Mode": "disabled",
// "Mobile-Os": "33"
// version.release: 13
// version.previewSdkInt: 0
// ,
// version.incremental: G996NKSU4EWH5, version.codename: REL, version.baseOS: ,
// board: exynos2100, bootloader: G996NKSU4EWH5, brand: samsung, device: t2s, display: TP1A.220624.014
// .
// G996NKSU4EWH5, fingerprint: samsung/t2sksx/t2s:13
// /
// TP1A.220624.014
// /
// G996NKSU4EWH5:user/release-keys, hardware: exynos2100, host: SWDK6206, id: TP1A.220624.014
// ,
// manufacturer: samsung, model: SM-G996N, product: t2sksx, supported32BitAbis: [
// armeabi-v7a, armeabi],
// supported64BitAbis: [
// arm64-v8a],
// supportedAbis: [
// arm64-v8a, armeabi-v7a, armeabi],
// tags: release-keys, type: user, isPhysicalDevice: true
// ,
// systemFeatures: [
// android.hardware.sensor.proximity, com.samsung.android.sdk.camera.processor, com
//     .samsung.feature.aodservice_v10, com.sec.feature
//     .motionrecognition_service, com.sec.feature.cover.sview, android.hardware
//     .telephony.ims.singlereg, android.hardware.sensor.accelerometer, android
//     .software.controls, android.hardware.faketouch, android

//
// if (Theme.of(context).platform == TargetPlatform.android) {
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
// String? deviceId = await _androidIdPlugin.getId();
// Utils.device_manifacture = androidInfo.manufacturer;
// Utils.device_name=androidInfo.model;
// Utils.device_model=androidInfo.brand;
// String combinedInfo = '$deviceId-${Utils.device_manifacture}';
// print("device uuid");
// Utils.device_id=uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
// print(Utils.device_id);
// print(Utils.device_name);
// print(Utils.device_manifacture);
// print(Utils.device_model);
// //return uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
// } else if (Theme.of(context).platform == TargetPlatform.iOS) {
// IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
// String? deviceId = iosInfo.identifierForVendor;
// Utils.device_name = iosInfo.name;
// Utils.device_manifacture = iosInfo.systemName;
// Utils.device_model=iosInfo.model;
// String combinedInfo = '$deviceId-${Utils.device_name}';
// Utils.device_id=uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
// print("device uuid");
// print(Utils.device_id);
// print(Utils.device_name);
// print(Utils.device_manifacture);
// print(Utils.device_model);
// // return uuid.v5(Uuid.NAMESPACE_URL, combinedInfo);
// }
