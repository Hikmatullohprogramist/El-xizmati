import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'category_cubit.freezed.dart';
part 'category_state.dart';

@injectable
class CategoryCubit extends BaseCubit<CategoryState, CategoryEvent> {
  CategoryCubit(this._commonRepository) : super(CategoryState()) {
    getCategories();
  }

  final CommonRepository _commonRepository;

  Future<void> getCategories() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final allItems = await _commonRepository.getCategories();
      final parents = allItems.where((e) => e.isParent).toList();
      updateState(
        (state) => state.copyWith(
          allItems: allItems,
          visibleItems: parents,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      final parentItems = states.allItems.where((e) => e.isParent).toList();

      updateState((state) => state.copyWith(visibleItems: parentItems));
    } else {
      final searchQuery = query.trim().toUpperCase();
      final searchResults = states.allItems
          .where((e) => e.name.toUpperCase().contains(searchQuery) == true)
          .toList();

      logger.w("searchResults = $searchResults");

      updateState((state) => state.copyWith(
            visibleItems: searchResults,
            loadState: searchResults.isNotEmpty
                ? LoadingState.success
                : LoadingState.empty,
          ));
    }
  }

  void setSelectedCategory(Category category) {
    var categories = states.allItems
        .where((e) => e.isNotParent && e.parentId == category.id)
        .toList();

    if (categories.isNotEmpty) {
      emitEvent(CategoryEvent(
        CategoryEventType.onOpenSubCategory,
        categories: categories,
        category: category,
      ));
    } else {
      emitEvent(CategoryEvent(
        CategoryEventType.onOpenProductList,
        categories: categories,
        category: category,
      ));
    }
  }
}
