import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/common_repository.dart';
import '../../../../../data/responses/category/category/category_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getCategories();
  }

  final CommonRepository repository;

  Future<void> getCategories() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final allItems = await repository.getCategories();
      final parents = allItems.where((e) => e.isParent).toList();
      updateState(
        (state) => state.copyWith(
          allItems: allItems,
          visibleItems: parents,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      final parentItems =
      states.allItems.where((element) => element.isParent).toList();

      updateState((state) => state.copyWith(visibleItems: parentItems));
    } else {
      final searchQuery = query.trim().toUpperCase();
      final searchResults = states.allItems
          .where((e) => e.name?.toUpperCase().contains(searchQuery) == true)
          .toList();

      updateState((state) => state.copyWith(
        visibleItems: searchResults,
        loadState: searchResults.isNotEmpty
            ? LoadingState.success
            : LoadingState.empty,
      ));
    }
  }

  void setSelectedCategory(CategoryResponse category) {
    var categories = states.allItems
        .where((element) => element.parent_id == category.id)
        .toList();

    if (categories.isNotEmpty) {
      emitEvent(PageEvent(
        PageEventType.onOpenSubCategory,
        categories: categories,
        category: category,
      ));
    } else {
      emitEvent(PageEvent(
        PageEventType.onOpenProductList,
        categories: categories,
        category: category,
      ));
    }
  }
}
