import 'dart:async';
import 'dart:convert';

import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/eds/eds_sign_in_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/eds_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/mappers/user_mappers.dart';

class EdsRepository {
  final AuthPreferences _authPreferences;
  final EdsService _edsService;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  EdsRepository(
    this._authPreferences,
    this._edsService,
    this._userEntityDao,
    this._userPreferences,
  );

  Future<EImzoModel?> createDoc() async {
    final response = await _edsService.createDoc();

    EImzoModel? eImzoModel;
    final int statusCode = response.statusCode;
    final resultClass = json.decode(utf8.decode(response.bodyBytes));
    if (statusCode == 200) {
      eImzoModel = EImzoModel.fromJson(resultClass);
    }
    return eImzoModel;
  }

  Future<int?> checkStatus(String documentId, Timer? _timer) async {
    final response = await _edsService.checkStatus(documentId, _timer);

    final int statusCode = response.statusCode;
    final resultClass = json.decode(utf8.decode(response.bodyBytes));
    if (statusCode == 200) {
      if (resultClass["status"] == 1) {
        _timer?.cancel();
      }
      return resultClass["status"];
    }
    return resultClass["status"];
  }

  Future<void> signIn(String sign) async {
    final response = await _edsService.signIn(sign: sign);

    final edsResponse = EdsSignInRootResponse.fromJson(response.data);
    final userResponse = edsResponse.user;
    if (edsResponse.token != null) {
      await _authPreferences.setToken(edsResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);

      await _userPreferences.setUserTin(userResponse?.tin);
      await _userPreferences.setUserPinfl(userResponse?.pinfl);
      await _userPreferences.setIdentityState(userResponse?.isRegistered);

      if (userResponse != null) {
        await _userEntityDao.insertUser(userResponse.toUserEntity());
      }
    }
    return;
  }
}
