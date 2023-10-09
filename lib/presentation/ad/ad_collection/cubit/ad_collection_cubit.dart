import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repo/ad_repository.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/loading_state.dart';
import '../../../../domain/model/ad/ad_response.dart';

part 'ad_collection_cubit.freezed.dart';

part 'ad_collection_state.dart';

@injectable
class AdCollectionCubit
    extends BaseCubit<AdCollectionBuildable, AdCollectionListenable> {
  AdCollectionCubit(this.adRepository, this.commonRepository)
      : super(AdCollectionBuildable()) {
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getHotDiscountAds(),
      getPopularAds(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;

  Future<void> getHotDiscountAds() async {
    try {
      log.i("recentlyViewerAds request");
      final hotDiscountAds = await adRepository.getRecentlyViewAds();
      build((buildable) => buildable.copyWith(
          hotDiscountAds: hotDiscountAds,
          hotDiscountAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.hotDiscountAds}");
    } catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(hotDiscountAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getPopularAds() async {
    try {
      log.i("recentlyViewerAds request");
      final popularAds = await adRepository.getRecentlyViewAds();
      build((buildable) => buildable.copyWith(
          popularAds: popularAds, popularAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.hotDiscountAds}");
    } catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
      // build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, AdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, AdResponse>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await adRepository.getAds(pageKey, _pageSize, "");
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }
}
