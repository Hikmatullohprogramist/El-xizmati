import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';

class CommonInterceptor extends QueuedInterceptor {
  CommonInterceptor(this._tokenPreferences);

  final TokenPreferences _tokenPreferences;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
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
    headers['MobileOsVersion'] = "33";

    var token = _tokenPreferences.token;
    if (token.isNotEmpty) {
      headers[RestHeaderKeys.authorization] = "Bearer $token";
    }

    options.headers.addAll(headers);
    handler.next(options);
  }
}
