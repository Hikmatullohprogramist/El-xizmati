import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';

@lazySingleton
class LanguageInterceptor extends QueuedInterceptor {
  LanguageInterceptor(this.languageStorage);

  final LanguageStorage languageStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var restCode = languageStorage.language.getRestCode();

    final headers = {'lang': restCode};
    final queryParameters = {'lang': restCode};
    headers['AcceptLanguage'] = restCode;
    options.headers.addAll(headers);
    options.queryParameters.addAll(queryParameters);
    handler.next(options);
  }
}
