import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../../../domain/models/ad/ad.dart';
import '../../../../../../../domain/models/ad/ad_list_type.dart';
import '../../../../../../common/core/base_cubit.dart';
import '../../../../../../data/repositories/favorite_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._favoriteRepository) : super(const PageState()) {
    getController();
  }

  final FavoriteRepository _favoriteRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
      // build((state) => state.copyWith(loading: false));
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await _favoriteRepository.getServiceFavoriteAds();
        if (adsList.length <= 1000) {
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

  Future<void> removeFavorite(Ad ad) async {
    try {
      await _favoriteRepository.removeFavorite(ad);
      states.controller?.itemList?.remove(ad);
      states.controller?.notifyListeners();
    } on DioException {
      display.error("xatolik yuz berdi");
    }
  }
}
