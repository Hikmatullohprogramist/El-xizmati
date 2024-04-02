import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/common_repository.dart';
import '../../../../data/responses/category/popular_category/popular_category_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(const PageState()) {
    getController();
  }

  final CommonRepository _repository;

  Future<void> getController() async {
    try {
      final controller =
          states.controller ?? getPagingController(status: 1);
      updateState(
          (state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
      // build((state) => state.copyWith(loading: false));
    }
  }

  PagingController<int, PopularCategoryResponse> getPagingController({
    required int status,
  }) {
    final adController = PagingController<int, PopularCategoryResponse>(
      firstPageKey: 1,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _repository.getPopularCategories(pageKey, 20);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(states.controller);
      },
    );
    return adController;
  }
}
