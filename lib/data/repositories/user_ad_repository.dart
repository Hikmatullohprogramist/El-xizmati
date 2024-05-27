import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_ad_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

import '../../domain/models/ad/user_ad_status.dart';

@LazySingleton()
class UserAdRepository {
  UserAdRepository(
    this.userAdService,
    this._stateRepository,
    this._userRepository,
  );

  final StateRepository _stateRepository;
  final UserAdService userAdService;
  final UserRepository _userRepository;

  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  }) async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await userAdService.getUserAds(
      page: page,
      limit: limit,
      userAdType: userAdStatus,
    );
    final response = UserAdRootResponse.fromJson(root.data).data.results;
    return response;
  }

  Future<void> deactivateAd(int adId) async {
    final response = await userAdService.deactivateAd(adId);
    return;
  }

  Future<void> activateAd(int adId) async {
    final response = await userAdService.activateAd(adId);
    return;
  }

  Future<void> deleteAd(int adId) async {
    final response = await userAdService.deleteAd(adId);
    return;
  }
}
