import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/common_api.dart';
import 'package:onlinebozor/domain/model/banner/banner_response.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

@LazySingleton(as: CommonRepository)
class CommonRepositoryImpl extends CommonRepository {
  final CommonApi _api;

  CommonRepositoryImpl(this._api);

  @override
  Future<List<BannerResponse>> getBanner() async {
    final response = await _api.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners ?? List.empty();
  }
}
