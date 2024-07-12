import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'favorite_products_cubit.freezed.dart';
part 'favorite_products_state.dart';

@injectable
class FavoriteProductsCubit
    extends BaseCubit<FavoriteProductsState, FavoriteProductsEvent> {
  FavoriteProductsCubit(this._favoriteRepository)
      : super(const FavoriteProductsState()) {
    initController();
  }

  final FavoriteRepository _favoriteRepository;

  Future<void> initController() async {
    final controller = states.controller ?? getController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, Ad> getController({required int status}) {
    final controller = PagingController<int, Ad>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        _favoriteRepository
            .getProductFavoriteAds()
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 1000) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              controller.error = error;
              if (error.isRequiredShowError) {
                stateMessageManager
                    .showErrorBottomSheet(error.localizedMessage);
              }
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }

  Future<void> removeFavorite(Ad ad) async {
    try {
      await _favoriteRepository.removeFromFavorite(ad.id);
      states.controller?.itemList?.remove(ad);
      states.controller?.notifyListeners();
    } catch (e) {
      logger.w(e);
    }
  }
}
