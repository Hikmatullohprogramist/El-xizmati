import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/model/ads/ads_response.dart';
import 'package:onlinebozor/domain/model/banner/banner_response.dart';

import '../../domain/repo/ads_repository.dart';
import '../api/ads_api.dart';
import '../storage/storage.dart';

@LazySingleton(as: AdsRepository)
class AdsRepositoryImpl extends AdsRepository {
  final AdsApi _api;
  final Storage _storage;

  AdsRepositoryImpl(this._api, this._storage);

  @override
  Future<List<AdsResponse>> getAds(int pageIndex, int pageSize) async {
    final response = await _api.getAdsList(
      pageIndex,
      pageSize,
    );
    final adsResponse =
        AdsRootResponse.fromJson(response.data).data?.results ?? List.empty();
    return adsResponse;
  }

  @override
  Future<List<BannerResponse>> getBanner() async {
    final response = await _api.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners ?? List.empty();
  }
}
