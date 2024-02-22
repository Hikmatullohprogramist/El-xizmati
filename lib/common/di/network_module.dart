import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/utils/dio_extensions.dart';

import '../intercepter/intercepter/app_intercepter.dart';
import '../intercepter/intercepter/language_intercepter.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio createDefaultDio(
    LanguageInterceptor languageInterceptor,
    AppInterceptor appInterceptor,
  ) {
    return Dio().setupDefaultParams([languageInterceptor, appInterceptor]);
  }
}
