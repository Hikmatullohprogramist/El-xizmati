import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/network/responses/banner/banner_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/data/datasource/network/services/public/dashboard_service.dart';
import 'package:El_xizmati/data/mappers/banner_mappers.dart';
import 'package:El_xizmati/data/mappers/category_mappers.dart';
import 'package:El_xizmati/domain/mappers/common_mapper_exts.dart';
import 'package:El_xizmati/domain/models/banner/banner_image.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/category/category_type.dart';

import '../datasource/network/sp_response/category/category_response/category_response.dart';

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

  Future<List<Results>> getCatalogCategories() async {
      final response = await _commonService.getCatalogCategories();
      final c = CategoryResponse.fromJson(response.data).data;
      return c.results;
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
