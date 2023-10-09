import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/loading_state.dart';
import 'package:onlinebozor/domain/model/ad/ad_response.dart';
import 'package:onlinebozor/domain/model/banner/banner_response.dart';
import 'package:onlinebozor/domain/model/popular_category/popular_category_response.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/repo/ad_repository.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(this.adRepository, this.commonRepository)
      : super(DashboardBuildable()) {
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getPopularCategories(),
      getRecentlyViewAds(),
      getBanners(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;

  Future<void> getPopularCategories() async {
    try {
      log.i("recentlyViewerAds request");
      final popularCategories =
          await commonRepository.getPopularCategories(1, 20);
      build((buildable) => buildable.copyWith(
            popularCategories: popularCategories,
            popularCategoriesState: AppLoadingState.success,
          ));
      log.i("recentlyViewerAds=${buildable.recentlyViewerAds}");
    } catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularCategoriesState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getRecentlyViewAds() async {
    try {
      log.i("recentlyViewerAds request");
      final recentlyAds = await adRepository.getRecentlyViewAds();
      build((buildable) => buildable.copyWith(
          recentlyViewerAds: recentlyAds,
          recentlyAdsState: AppLoadingState.success));
      log.i("recentlyViewerAds=${buildable.recentlyViewerAds}");
    } catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(recentlyAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getBanners() async {
    try {
      build((buildable) =>
          buildable.copyWith(bannersState: AppLoadingState.loading));
      final banners = await commonRepository.getBanner();
      build((buildable) => buildable.copyWith(
          banners: banners, bannersState: AppLoadingState.success));
      log.i("${buildable.banners}");
    } catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(bannersState: AppLoadingState.error));
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
        firstPageKey: 1, invisibleItemsThreshold: 100);
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

  void addPage() {}
}
