import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/category/category_selection/category_selection_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_category_cubit.freezed.dart';

part 'selection_category_state.dart';

@Injectable()
class SelectionCategoryCubit
    extends BaseCubit<SelectionCategoryBuildable, SelectionCategoryListenable> {
  SelectionCategoryCubit(
    this._repository,
  ) : super(SelectionCategoryBuildable()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final items = await _repository.getCategoriesForCreationAd();
      log.i(items.toString());
      build(
        (buildable) => buildable.copyWith(
          items: items,
          itemsLoadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      build(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }
  }
}
