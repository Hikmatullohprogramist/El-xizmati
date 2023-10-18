import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/loading_state.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/model/categories/category/category_response.dart';

part 'category_cubit.freezed.dart';
part 'category_state.dart';

@injectable
class CategoryCubit extends BaseCubit<CategoryBuildable, CategoryListenable> {
  CategoryCubit(this._repository) : super(CategoryBuildable()) {
    getCategories();
  }

  CommonRepository _repository;

  Future<void> getCategories() async {
    try {
      final categories = await _repository.getCategories();
      log.i(categories.toString());
      build((buildable) => buildable.copyWith(
          categories: categories, categoriesState: AppLoadingState.success));
    } catch (exception) {
      build((buildable) =>
          buildable.copyWith(categoriesState: AppLoadingState.error));
    }
  }
}
