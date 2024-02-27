import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/category/category_selection/category_selection_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_category_cubit.freezed.dart';

part 'selection_category_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final items = await _repository.getCategoriesForCreationAd();
      log.i(items.toString());
      updateState(
        (state) => state.copyWith(
          items: items,
          itemsLoadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState(
        (state) => state.copyWith(itemsLoadState: LoadingState.error),
      );
    }
  }
}
