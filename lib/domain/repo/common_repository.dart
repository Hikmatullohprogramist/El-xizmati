import '../model/banner/banner_response.dart';

abstract class CommonRepository {
  Future<List<BannerResponse>> getBanner();
}
