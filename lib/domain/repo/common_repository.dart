import 'package:onlinebozor/domain/model/category/category_response.dart';
import 'package:onlinebozor/domain/model/popular_category/popular_category_response.dart';
import 'package:onlinebozor/domain/model/search/search_response.dart';

import '../model/banner/banner_response.dart';

abstract class CommonRepository {
  Future<List<BannerResponse>> getBanner();

  Future<List<CategoryResponse>> getCategories();

  Future<List<PopularCategoryResponse>> getPopularCategories(int pageIndex, int pageSize);

  Future<List<Ad>> getSearch(String query);
}
