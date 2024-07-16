import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';

class LanguageInterceptor extends QueuedInterceptor {
  LanguageInterceptor(this._languagePreferences);

  final LanguagePreferences _languagePreferences;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var restCode = _languagePreferences.language.getRestCode();

    final headers = {'lang': restCode};
    final queryParameters = {'lang': restCode};
    headers['AcceptLanguage'] = restCode;
    options.headers.addAll(headers);
    options.queryParameters.addAll(queryParameters);
    handler.next(options);
  }
}
