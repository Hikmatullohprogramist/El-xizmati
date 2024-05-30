import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'category_selection_cubit.freezed.dart';
part 'category_selection_state.dart';

@Injectable()
class CategorySelectionCubit
    extends BaseCubit<CategorySelectionState, CategorySelectionEvent> {
  final AdCreationRepository _adCreationRepository;

  CategorySelectionCubit(
    this._adCreationRepository,
  ) : super(CategorySelectionState());

  void setInitialParams(AdType adType) {
    updateState((state) => state.copyWith(adType: adType));

    getItems();
  }

  Future<void> getItems() async {
    try {
      final allItems = await _adCreationRepository
          .getCategoriesForCreationAd(states.adType.name.toUpperCase());

      final visibleItems = allItems.where((e) => e.isParent).toList();
      logger.e(allItems.toString());
      updateState((state) => state.copyWith(
            allItems: allItems,
            visibleItems: visibleItems,
            loadState: LoadingState.success,
          ));
    } catch (exception) {
      logger.e(exception.toString());
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

  Future<void> selectCategory(Category category) async {
    updateState((state) => state.copyWith(selectedItem: category));

    final children = states.allItems
        .where((e) => e.isParent && e.parentId == category.id)
        .toList();

    if (children.isEmpty) {
      emitEvent(CategorySelectionEvent(CategorySelectionEventType.closePage,
          category: category));
    } else {
      updateState((state) => state.copyWith(visibleItems: children));
    }
  }

  Future<void> backWithoutSelectedCategory() async {
    emitEvent(CategorySelectionEvent(CategorySelectionEventType.closePage));
  }
}
