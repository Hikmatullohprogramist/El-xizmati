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
  PageCubit(this._repository) : super(PageState());

  final AdCreationRepository _repository;

  void setInitialParams(AdType adType) {
    updateState((state) => state.copyWith(adType: adType));

    getItems();
  }

  Future<void> getItems() async {
    try {
      final allItems = await _repository
          .getCategoriesForCreationAd(states.adType.name.toUpperCase());

      final visibleItems = allItems.where((e) => e.isParent).toList();
      log.e(allItems.toString());
      updateState((state) => state.copyWith(
            allItems: allItems,
            visibleItems: visibleItems,
            loadState: LoadingState.success,
          ));
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  Future<void> selectCategory(CategoryResponse category) async {
    updateState((state) => state.copyWith(selectedItem: category));

    final visibleItems = states.allItems
        .where((element) => element.parent_id == category.id)
        .toList();

    if (visibleItems.isEmpty) {
      emitEvent(PageEvent(PageEventType.closePage, category: category));
    } else {
      updateState((state) => state.copyWith(visibleItems: visibleItems));
    }
  }

  Future<void> backWithoutSelectedCategory() async {
    emitEvent(PageEvent(PageEventType.closePage));
  }
}
