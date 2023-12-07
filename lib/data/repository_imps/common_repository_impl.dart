import 'package:injectable/injectable.dart';

import '../../domain/repositories/common_repository.dart';
import '../responses/banner/banner_response.dart';
import '../responses/category/category/category_response.dart';
import '../responses/category/popular_category/popular_category_response.dart';
import '../services/common_service.dart';
import '../storages/categories_storage.dart';

@LazySingleton(as: CommonRepository)
class CommonRepositoryImpl extends CommonRepository {
  final CommonService _commonService;
  final CategoriesStorage _categoriesStorage;

  CommonRepositoryImpl(this._commonService, this._categoriesStorage);

  @override
  Future<List<BannerResponse>> getBanner() async {
    final response = await _commonService.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners;
  }

  @override
  Future<List<CategoryResponse>> getCategories() async {
    final localCategories = _categoriesStorage.categories
        .callList()
        .cast<CategoryResponse>();
    if (localCategories.isEmpty) {
      final response = await _commonService.getCategories();
      final categories = CategoryRootResponse.fromJson(response.data).data;
      await _categoriesStorage.categories.set(categories);
      return categories;
    } else {
      return localCategories;
    }
  }

  @override
  Future<List<PopularCategoryResponse>> getPopularCategories(
      int pageIndex, int pageSize) async {
    final response =
        await _commonService.getPopularCategories(pageIndex, pageSize);
    final popularCategories =
        PopularRootCategoryResponse.fromJson(response.data).data;
    return popularCategories;
  }
}
