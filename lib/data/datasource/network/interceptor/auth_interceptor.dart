import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';

class AuthInterceptor extends Interceptor {
  final AdEntityDao _adEntityDao;
  final AuthPreferences _authPreferences;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  AuthInterceptor(
    this._adEntityDao,
    this._authPreferences,
    this._userAddressEntityDao,
    this._userEntityDao,
    this._userPreferences,
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = _authPreferences.token;
    if (token.isNotEmpty) {
      final headers = {RestHeaderKeys.authorization: "Bearer $token"};
      options.headers.addAll(headers);
    }

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _adEntityDao.clear();
        await _authPreferences.clear();
        await _userEntityDao.clear();
        await _userAddressEntityDao.clear();
        await _userPreferences.clear();

        // final requestOptions = err.requestOptions;
        // final path = requestOptions.path;
        // final actualHeaders = requestOptions.headers
        //   ..remove(RestHeaderKeys.authorization);

        // final options = Options(
        //   method: err.requestOptions.method,
        //   headers: actualHeaders,
        // );

        // final Dio dio = Dio();

        // final response = await dio.request(path, options: options);
        // return handler.resolve(response);

        return handler.next(err);
      } on DioError catch (e) {
        return handler.next(e);
      }
    }

    return handler.next(err);
  }
}
