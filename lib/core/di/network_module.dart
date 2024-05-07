import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/intercepter/common_intercepter.dart';
import 'package:onlinebozor/data/datasource/network/intercepter/language_intercepter.dart';
import 'package:onlinebozor/data/utils/dio_extensions.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio createDefaultDio(
    CommonInterceptor commonInterceptor,
    LanguageInterceptor languageInterceptor,
  ) {
    return Dio().setupDefaultParams([languageInterceptor, commonInterceptor]);
  }
}
