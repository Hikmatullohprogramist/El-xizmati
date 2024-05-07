import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/categories_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/banner/banner_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/datasource/network/services/common_service.dart';

@LazySingleton()
class CommonRepository {
  final CategoriesStorage _categoriesStorage;
  final CommonService _commonService;

  CommonRepository(
    this._commonService,
    this._categoriesStorage,
  );

  Future<List<BannerResponse>> getBanner() async {
    final response = await _commonService.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners;
  }

  Future<List<CategoryResponse>> getCategories() async {
    // final localCategories = _categoriesStorage.categories
    //     .callList()
    //     .cast<CategoryResponse>();
    // if (localCategories.isEmpty) {
    final response = await _commonService.getCategories();
    final categories = CategoryRootResponse.fromJson(response.data).data;
    // await _categoriesStorage.categories.set(categories);
    return categories;
    // } else {
    //   return localCategories;
    // }
  }

  Future<List<PopularCategory>> getPopularCategories(
    int page,
    int limit,
  ) async {
    final response = await _commonService.getPopularCategories(page, limit);
    final categories = PopularRootCategoryResponse.fromJson(response.data).data;
    return categories;
  }
}
