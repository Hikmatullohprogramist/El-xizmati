import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/banner/banner_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/datasource/network/services/common_service.dart';
import 'package:onlinebozor/data/mappers/category_mapper.dart';
import 'package:onlinebozor/domain/models/category/category.dart';

// @LazySingleton()
class CommonRepository {
  final CategoryEntityDao _categoryEntityDao;
  final CommonService _commonService;

  CommonRepository(
    this._categoryEntityDao,
    this._commonService,
  );

  Future<List<BannerResponse>> getBanner() async {
    final response = await _commonService.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners;
  }

  Future<List<Category>> getCategories() async {
    final count = await _categoryEntityDao.getCategoriesCount() ?? 0;
    if (count > 0) {
      final entities = await _categoryEntityDao.getCategories();
      return entities.map((e) => e.toCategory()).toList();
    } else {
      final response = await _commonService.getCategories();
      final categories = CategoryRootResponse.fromJson(response.data).data;
      await _categoryEntityDao.upsertAll(
        categories.map((e) => e.toCategoryEntity()).toList(),
      );
      return categories.map((e) => e.toCategory()).toList();
    }
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
