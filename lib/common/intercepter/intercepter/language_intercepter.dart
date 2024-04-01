import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/utils/rest_mappers.dart';

import '../../../data/storages/language_storage.dart';
import '../../../domain/models/language/language.dart';

@lazySingleton
class LanguageInterceptor extends QueuedInterceptor {
  LanguageInterceptor(this.languageStorage);

  final LanguageStorage languageStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var languageName = languageStorage.languageName.call();
    Language language = Language.uzbekLatin;

    language = languageName == Language.uzbekCyrill.name
        ? Language.uzbekCyrill
        : languageName == Language.russian.name
            ? Language.russian
            : Language.uzbekLatin;
    var restCode = language.getRestCode();

    final headers = {'lang': restCode};
    final queryParameters = {'lang': restCode};
    headers['AcceptLanguage'] = restCode;
    options.headers.addAll(headers);
    options.queryParameters.addAll(queryParameters);
    handler.next(options);
  }
}
