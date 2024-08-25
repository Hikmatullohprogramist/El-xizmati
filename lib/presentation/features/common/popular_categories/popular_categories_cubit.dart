import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/data/repositories/common_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'popular_categories_cubit.freezed.dart';
part 'popular_categories_state.dart';

@injectable
class PopularCategoriesCubit
    extends BaseCubit<PopularCategoriesState, PopularCategoriesEvent> {
  PopularCategoriesCubit(this._commonRepository)
      : super(const PopularCategoriesState()) {
    initController();
  }

  final CommonRepository _commonRepository;

  Future<void> initController() async {
    final controller = states.controller ?? getController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, PopularCategory> getController({required int status}) {
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
