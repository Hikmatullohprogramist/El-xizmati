import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/language_storage.dart';

@lazySingleton
class LanguageInterceptor extends QueuedInterceptor {
  LanguageInterceptor(this.languageStorage);

  final LanguageStorage languageStorage;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String languageName = languageStorage.languageName() ?? 'uz';
    final headers = {'lang': languageName};
    final queryParameters = {'lang': languageName};
    headers['AcceptLanguage'] = languageName;
    options.headers.addAll(headers);
    options.queryParameters.addAll(queryParameters);
    handler.next(options);
  }
}
