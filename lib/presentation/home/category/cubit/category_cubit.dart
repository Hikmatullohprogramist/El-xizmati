import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/AdRouteType.dart';
import '../../../../data/model/categories/category/category_response.dart';

part 'category_cubit.freezed.dart';
part 'category_state.dart';

@injectable
class CategoryCubit extends BaseCubit<CategoryBuildable, CategoryListenable> {
  CategoryCubit(this._repository) : super(CategoryBuildable()) {
    getCategories();
  }

  final CommonRepository _repository;

  Future<void> getCategories() async {
    try {
      final categories = await _repository.getCategories();
      final result = categories.where((element) => element.parent_id == 0).toList();
      log.i(categories.toString());
      build((buildable) => buildable.copyWith(
          categories: result, categoriesState: AppLoadingState.success));
    } catch (exception) {
      log.e(exception.toString());
      display.error(exception.toString());
      build((buildable) =>
          buildable.copyWith(categoriesState: AppLoadingState.error));
    }
  }
}
