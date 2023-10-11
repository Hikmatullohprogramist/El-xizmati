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
    headers['App-Version-Code'] = DeviceInfo.app_version_code;
    headers['App-Version-Name'] = DeviceInfo.app_version_name;
    headers['Device_id'] = DeviceInfo.device_id;
    headers['Device-Name'] = DeviceInfo.device_name;
    headers['Device-Manufacturer'] = DeviceInfo.device_manufacture;
    headers['Device-Model'] = DeviceInfo.device_model;
    headers['User-Agent'] = DeviceInfo.user_agent;

    options.headers.addAll(headers);
    handler.next(options);
  }
}
