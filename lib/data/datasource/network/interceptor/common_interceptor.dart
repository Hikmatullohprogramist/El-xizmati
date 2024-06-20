import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';

class CommonInterceptor extends QueuedInterceptor {
  CommonInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userAgent = "${DeviceInfo.deviceId}"
        "&&${DeviceInfo.deviceModel}"
        "&&${DeviceInfo.deviceName}"
        "&&APPLICATION";

    final headers = {'AppVersionCode': DeviceInfo.appVersionCode};

    headers['AppVersionName'] = DeviceInfo.appVersionName;
    headers['DeviceId'] = DeviceInfo.deviceId;
    headers['DeviceName'] = DeviceInfo.deviceName;
    headers['DeviceManufacturer'] = DeviceInfo.deviceManufacture;
    headers['DeviceModel'] = DeviceInfo.deviceModel;
    headers['User-Agent'] = userAgent;
    headers['MobileOs'] = DeviceInfo.mobileOs;
    headers['NightMode'] = DeviceInfo.nightMode;
    headers['MobileOsType'] = DeviceInfo.mobileOsType;
    headers['MobileOsVersion'] = "33";

    options.headers.addAll(headers);
    handler.next(options);
  }
}
