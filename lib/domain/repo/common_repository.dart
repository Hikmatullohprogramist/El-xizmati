import 'package:onlinebozor/domain/model/category/category_response.dart';

import '../model/banner/banner_response.dart';

abstract class CommonRepository {
  Future<List<BannerResponse>> getBanner();

  Future<List<CategoryResponse>> getCategories();
}
