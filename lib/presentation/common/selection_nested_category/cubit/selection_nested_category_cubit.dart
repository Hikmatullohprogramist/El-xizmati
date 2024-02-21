import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/responses/category/category/category_response.dart';
import '../../../../data/repositories/common_repository.dart';

part 'selection_nested_category_cubit.freezed.dart';

part 'selection_nested_category_state.dart';

@Injectable()
class SelectionNestedCategoryCubit extends BaseCubit<
    SelectionNestedCategoryBuildable, SelectionNestedCategoryListenable> {
  SelectionNestedCategoryCubit(
    this._repository,
  ) : super(SelectionNestedCategoryBuildable()) {
    getCategories();
  }

  final CommonRepository _repository;

  Future<void> getCategories() async {
    try {
      final categories = await _repository.getCategories();
      final result =
          categories.where((element) => element.parent_id == 0).toList();
      log.i(categories.toString());
      build((buildable) => buildable.copyWith(
          selectCategories: result,
          categories: categories,
          categoriesState: LoadingState.success));
    } on DioException catch (exception) {
      log.e(exception.toString());
    }
  }

  Future<void> selectCategory(CategoryResponse categoryResponse) async {
    build((buildable) =>
        buildable.copyWith(selectedCategoryResponse: categoryResponse));
    // display.success(categoryResponse.id.toString());
    final result = buildable.categories
        .where((element) => element.parent_id == categoryResponse.id)
        .toList();
    if (result.isEmpty) {
      invoke(SelectionNestedCategoryListenable(
          SelectionNestedCategoryEffect.back,
          categoryResponse: categoryResponse));
    } else {
      build((buildable) => buildable.copyWith(selectCategories: result));
    }
  }

  Future<void> backCategory() async {
    final result = buildable.categories
        .where((element) => element.parent_id == 0)
        .toList();
    build((buildable) => buildable.copyWith(
        selectCategories: result, selectedCategoryResponse: null));
    if (buildable.selectedCategoryResponse == null) {
      invoke(SelectionNestedCategoryListenable(
          SelectionNestedCategoryEffect.back));
    }
  }
}