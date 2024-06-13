import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'popular_categories_cubit.freezed.dart';
part 'popular_categories_state.dart';

@injectable
class PopularCategoriesCubit
    extends BaseCubit<PopularCategoriesState, PopularCategoriesEvent> {
  PopularCategoriesCubit(this._commonRepository)
      : super(const PopularCategoriesState()) {
    getController();
  }

  final CommonRepository _commonRepository;

  Future<void> getController() async {
    final controller = states.controller ?? getPagingController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, PopularCategory> getPagingController({
    required int status,
  }) {
    final controller = PagingController<int, PopularCategory>(
      firstPageKey: 1,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        _commonRepository
            .getPopularCategories(pageKey, 20)
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 19) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              logger.e(error);
              controller.error = error;
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }
}
