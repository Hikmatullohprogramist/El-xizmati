import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';

import '../../data/responses/banner/banner_response.dart';
import '../../data/responses/category/category/category_response.dart';
import '../../data/responses/category/popular_category/popular_category_response.dart';
import '../../data/services/common_service.dart';
import '../../data/storages/categories_storage.dart';

@LazySingleton()
class CommonRepository {
  final CommonService _commonService;
  final CategoriesStorage _categoriesStorage;

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

  Future<List<PopularCategoryResponse>> getPopularCategories(
      int pageIndex, int pageSize) async {
    final response =
        await _commonService.getPopularCategories(pageIndex, pageSize);
    final popularCategories =
        PopularRootCategoryResponse.fromJson(response.data).data;
    return popularCategories;
  }

  Future<List<PaymentTypeResponse>> getPaymentTypes() async {
    final response = await _commonService.getPaymentTypes();
    final paymentTypes = PaymentTypeRootResponse.fromJson(response.data).data;
    return paymentTypes;
  }

  Future<List<UnitResponse>> getUnits() async {
    final response = await _commonService.getUnits();
    final units = UnitRootResponse.fromJson(response.data).data;
    return units;
  }

}
