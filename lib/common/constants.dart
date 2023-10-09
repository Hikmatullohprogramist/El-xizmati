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
