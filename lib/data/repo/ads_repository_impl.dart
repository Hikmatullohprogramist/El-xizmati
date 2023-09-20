import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/model/ads/ads_response.dart';

import '../../domain/repo/ads_repository.dart';
import '../api/ads_api.dart';
import '../storage/storage.dart';

@LazySingleton(as: AdsRepository)
class AdsRepositoryImpl extends AdsRepository {
  final AdsApi _api;
  final Storage _storage;

  AdsRepositoryImpl(this._api, this._storage);

  @override
  Future<AdsResponse> getAds(int pageIndex, int pageSize) async {
    final response =
        await _api.getAdsList(pageSize = pageSize, pageIndex = pageIndex);
    final adsResponse = AdsResponse.fromJson(response.data);
    return adsResponse;
  }
}
