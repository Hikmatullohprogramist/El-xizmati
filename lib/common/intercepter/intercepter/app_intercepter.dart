import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/constants.dart';

@lazySingleton
class AppInterceptor extends QueuedInterceptor {
  AppInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = {'X-Api-Key': ""};
    headers['AppVersionCode'] = DeviceInfo.app_version_code;
    headers['AppVersionName'] = DeviceInfo.app_version_name;
    headers['DeviceId'] = DeviceInfo.device_id;
    headers['DeviceName'] = DeviceInfo.device_name;
    headers['DeviceManufacturer'] = DeviceInfo.device_manufacture;
    headers['DeviceModel'] = DeviceInfo.device_model;
    headers['UserAgent'] =
        "${DeviceInfo.device_id}&&${DeviceInfo.device_model}&&${DeviceInfo.device_name}&&APPLICATION";
    headers['MobileOs'] = DeviceInfo.mobile_os;
    headers['NightMode'] =DeviceInfo.night_mode;
    options.headers.addAll(headers);
    handler.next(options);
  }
}
