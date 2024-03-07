import 'package:easy_localization/easy_localization.dart';

abstract class Constants {
  static String baseUrl = 'https://api.online-bozor.uz/api/mobile/';
  //static String baseUrl = 'https://api.online-bozor.uz/api/';
  static String baseUrlCabinet = 'https://api.cabinet.online-bozor.uz/';
  static String baseUrlForImage = 'https://api.online-bozor.uz/uploads/images/';
  static var formatter = NumberFormat('###,000');
}

abstract class DeviceInfo {
  static String deviceName = "";
  static String deviceId = "";
  static String deviceManufacture = "";
  static String deviceModel = "";
  static String userAgent = "$deviceId&&$deviceModel&&$deviceName&&APPLICATION";
  static String appVersionCode = "";
  static String appVersionName = "";
  static String mobileOs = "33";
  static String nightMode = "DISABLED";
  static String mobileOsType = "android";
}
