import 'package:El_xizmati/data/datasource/network/responses/ad/ad_detail/user_ad_detail_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_ad_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/error/app_locale_exception.dart';
import 'package:El_xizmati/domain/models/ad/user_ad_status.dart';

class UserAdRepository {
  final AuthPreferences _authPreferences;
  final UserAdService _userAdService;
  final UserPreferences _userPreferences;

  UserAdRepository(
    this._authPreferences,
    this._userAdService,
    this._userPreferences,
  );

  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _userAdService.getUserAds(
      page: page,
      limit: limit,
      userAdType: userAdStatus,
    );
    final response = UserAdRootResponse.fromJson(root.data).data.results;
    return response;
  }

  Future<UserAdDetail> getUserAdDetail({required int id}) async {
    final response = await _userAdService.getUserAdDetail(adId: id);
    final adsResponse = UserAdDetailRootResponse.fromJson(response.data).data;
    return adsResponse.userAdDetail;
  }

  Future<void> deactivateAd(int adId) async {
    final response = await _userAdService.deactivateAd(adId);
    return;
  }

  Future<void> activateAd(int adId) async {
    final response = await _userAdService.activateAd(adId);
    return;
  }

  Future<void> deleteAd(int adId) async {
    final response = await _userAdService.deleteAd(adId);
    return;
  }
}
