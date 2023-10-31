import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../constants.dart';

@lazySingleton
class AppInterceptor extends QueuedInterceptor {
  AppInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = {'AppVersionCode': DeviceInfo.app_version_code};
    headers['AppVersionName'] = DeviceInfo.app_version_name;
    headers['DeviceId'] = DeviceInfo.device_id;
    headers['DeviceName'] = DeviceInfo.device_name;
    headers['DeviceManufacturer'] = DeviceInfo.device_manufacture;
    headers['DeviceModel'] = DeviceInfo.device_model;
    headers['User-Agent'] =
        "${DeviceInfo.device_id}&&${DeviceInfo.device_model}&&${DeviceInfo.device_name}&&APPLICATION";
    headers['MobileOs'] = DeviceInfo.mobile_os;
    headers['NightMode'] = DeviceInfo.night_mode;
    headers['MobileOsType'] = DeviceInfo.mobile_os_type;
    headers['MobileOsVersion']="33";
    options.headers.addAll(headers);
    handler.next(options);
  }
}
