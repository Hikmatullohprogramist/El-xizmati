import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_ad_service.dart';

import '../../domain/models/ad/user_ad_status.dart';

@LazySingleton()
class UserAdRepository {
  UserAdRepository(this.userAdService);

  final UserAdService userAdService;

  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  }) async {
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
