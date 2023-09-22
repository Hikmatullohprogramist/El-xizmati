import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/model/ads/ads_response.dart';
import 'package:onlinebozor/domain/model/banner/banner_response.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/repo/ads_repository.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(this.adsRepository) : super(DashboardBuildable()) {
    getBanners();
    getController();
  }

  static const _pageSize = 20;

  final AdsRepository adsRepository;

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
      build((buildable) => buildable.copyWith(loading: false));
    }
  }

  PagingController<int, AdsResponse> getAdsController({
    required int status,
  }) {
    final adsController = PagingController<int, AdsResponse>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adsController.addPageRequestListener(
      (pageKey) async {
        final adsList = await adsRepository.getAds(pageKey, _pageSize);
        if (adsList.length <= 19) {
          adsController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adsController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adsController;
  }

  Future<void> getBanners() async {
    log.i("${buildable.banners}");
    try {
      final banners = await adsRepository.getBanner();
      build((buildable) => buildable.copyWith(banners: banners));
      log.i("${buildable.banners}");
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}
