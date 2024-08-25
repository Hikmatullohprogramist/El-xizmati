import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/network/responses/banner/banner_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/category/category_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/data/datasource/network/services/public/dashboard_service.dart';
import 'package:El_xizmati/data/mappers/banner_mappers.dart';
import 'package:El_xizmati/data/mappers/category_mappers.dart';
import 'package:El_xizmati/domain/mappers/common_mapper_exts.dart';
import 'package:El_xizmati/domain/models/banner/banner_image.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/category/category_type.dart';

class CommonRepository {
  final CategoryEntityDao _categoryEntityDao;
  final DashboardService _commonService;

  CommonRepository(
    this._categoryEntityDao,
    this._commonService,
  );

  Future<List<BannerImage>> getBanners() async {
    final response = await _commonService.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners.map((e) => e.toBanner()).toList();
  }

  Future<List<Category>> getCatalogCategories(CategoryType categoryType) async {
    final type = categoryType.stringValue;
    final count = await _categoryEntityDao.getCategoriesCountByType(type) ?? 0;
    if (count <= 0) {
      final response = await _commonService.getCatalogCategories();
      final c = CategoryRootResponse.fromJson(response.data).data;
      final entities = c.map((e) => e.toCategoryEntity(categoryType)).toList();
      await _categoryEntityDao.insertCategories(entities);
    }

    final entities = await _categoryEntityDao.getCategoriesByType(type);
    return entities.map((e) => e.toCategory()).toList();
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
