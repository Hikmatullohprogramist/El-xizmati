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
    final headers = {'X-Api-Key': ""};
    final queryParameters = {'lang': languageName};
    queryParameters['Accept-Language'] = languageName;
    headers['Accept-Language'] = languageName;
    headers['lang'] = languageName;
    options.headers.addAll(headers);
    options.queryParameters.addAll(queryParameters);
    handler.next(options);
  }
}
