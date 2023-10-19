import 'package:easy_localization/easy_localization.dart';

abstract class Constants {
  static String baseUrl = 'https://api.online-bozor.uz/api/mobile/';
  static String baseUrlForImage = 'https://api.online-bozor.uz/uploads/images/';
  static var formatter = NumberFormat('###,000');
}

enum AdsStatusType { top, standard }

enum AdListType {
  list,
  popularCategory,
  category,
}

enum Currency { USD, UZB }

abstract class DeviceInfo {
  static String device_name = "";
  static String device_id = "";
  static String device_manufacture = "";
  static String device_model = "";
  static String user_agent =
      "$device_id&&$device_model&&$device_name&&APPLICATION";
  static String app_version_code = "";
  static String app_version_name = "";
  static String mobile_os = "33";
  static String night_mode = "DISABLED";
  static String mobile_os_type = "android";
}
