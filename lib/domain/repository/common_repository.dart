import '../../data/model/banner/banner_response.dart';
import '../../data/model/categories/category/category_response.dart';
import '../../data/model/categories/popular_category/popular_category_response.dart';

abstract class CommonRepository {
  Future<List<BannerResponse>> getBanner();

  Future<List<CategoryResponse>> getCategories();

  Future<List<PopularCategoryResponse>> getPopularCategories(
      int pageIndex, int pageSize);

   Future<void> getCurrency();
}
