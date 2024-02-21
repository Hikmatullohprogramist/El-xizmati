import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../common/core/base_cubit_new.dart';
import '../../../../../data/repositories/common_repository.dart';
import '../../../../../data/responses/category/category/category_response.dart';

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
          categories: result, categoriesState: LoadingState.success));
    }on DioException  catch (exception) {
      log.e(exception.toString());
      display.error(exception.toString());
      build((buildable) =>
          buildable.copyWith(categoriesState: LoadingState.error));
    }
  }
}
