import 'package:El_xizmati/data/datasource/network/sp_response/category/category_response/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/common_repository.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/category/category_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'category_cubit.freezed.dart';
part 'category_state.dart';

@injectable
class CategoryCubit extends BaseCubit<CategoryState, CategoryEvent> {
  CategoryCubit(this._commonRepository) : super(CategoryState()) {
   // getCatalogCategories();
    setCategories();
  }

  final CommonRepository _commonRepository;

  void setCategories(){
    List<Results> allItems=[];
     allItems.add(Results(0, "Tozalash", ""));
     allItems.add(Results(1, "Tuzatish", ""));
     allItems.add(Results(0, "Remont", ""));
     allItems.add(Results(1, "Bo'yash", ""));
     allItems.add(Results(0, "Tozalash", ""));
     allItems.add(Results(1, "Tuzatish", ""));
     allItems.add(Results(0, "Tozalash", ""));
     allItems.add(Results(1, "Tuzatish", ""));
     allItems.add(Results(0, "Remont", ""));
     allItems.add(Results(1, "Bo'yash", ""));
    allItems.add(Results(0, "Tozalash", ""));
    allItems.add(Results(1, "Tuzatish", ""));
    allItems.add(Results(0, "Tozalash", ""));
    allItems.add(Results(1, "Tuzatish", ""));
    allItems.add(Results(0, "Remont", ""));
    allItems.add(Results(1, "Bo'yash", ""));
    allItems.add(Results(0, "Tozalash", ""));
    allItems.add(Results(1, "Tuzatish", ""));

    updateState((state) => state.copyWith(
      visibleItems: allItems,
      loadState: LoadingState.success,
    ));
  }

  Future<void> getCatalogCategories() async {
    await _commonRepository
        .getCatalogCategories()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                loadState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          final parents = data;
          updateState((state) => state.copyWith(
                allItems: data,
                visibleItems: parents,
                loadState: LoadingState.success,
              ));
        })
        .onError((error) {
          logger.e(error.toString());
          updateState((state) => state.copyWith(loadState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  void setSearchQuery(String? query) {
    if (query == null || query.trim().isEmpty) {
      final parentItems = states.allItems;

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

  void setSelectedCategory(Results category) {
    var categories = states.allItems
        .where((e) => e.id == category.id)
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
