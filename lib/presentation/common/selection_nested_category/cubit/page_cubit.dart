import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/responses/category/category/category_response.dart';
import '../../../../domain/models/ad/ad_type.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final allCategories = await _repository.getCategoriesForCreationAd(
        AdType.product.name.toUpperCase(),
      );
      final categories = allCategories.where((e) => e.parent_id == 0).toList();
      log.i(allCategories.toString());
      updateState(
        (state) => state.copyWith(
          visibleCategories: categories,
          allCategories: allCategories,
          categoriesState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
    }
  }

  Future<void> selectCategory(CategoryResponse category) async {
    updateState((state) => state.copyWith(selectedCategory: category));

    final categories = states.allCategories
        .where((element) => element.parent_id == category.id)
        .toList();

    if (categories.isEmpty) {
      emitEvent(PageEvent(PageEventType.closePage, category: category));
    } else {
      updateState((state) => state.copyWith(visibleCategories: categories));
    }
  }

  Future<void> backWithoutSelectedCategory() async {
    emitEvent(PageEvent(PageEventType.closePage));
  }
}
