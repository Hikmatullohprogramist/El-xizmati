import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../constants.dart';

@lazySingleton
class AppInterceptor extends QueuedInterceptor {
  AppInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = {'AppVersionCode': DeviceInfo.appVersionCode};
    headers['AppVersionName'] = DeviceInfo.appVersionName;
    headers['DeviceId'] = DeviceInfo.deviceId;
    headers['DeviceName'] = DeviceInfo.deviceName;
    headers['DeviceManufacturer'] = DeviceInfo.deviceManufacture;
    headers['DeviceModel'] = DeviceInfo.deviceModel;
    headers['User-Agent'] =
        "${DeviceInfo.deviceId}&&${DeviceInfo.deviceModel}&&${DeviceInfo.deviceName}&&APPLICATION";
    headers['MobileOs'] = DeviceInfo.mobileOs;
    headers['NightMode'] = DeviceInfo.nightMode;
    headers['MobileOsType'] = DeviceInfo.mobileOsType;
    headers['MobileOsVersion']="33";
    options.headers.addAll(headers);
    handler.next(options);
  }
}
