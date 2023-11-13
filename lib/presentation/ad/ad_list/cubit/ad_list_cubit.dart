import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';
import 'package:onlinebozor/domain/repository/common_repository.dart';

import '../../../../common/enum/loading_enum.dart';
import '../../../../domain/model/ad_enum.dart';
import '../../../../domain/repository/ad_repository.dart';

part 'ad_list_cubit.freezed.dart';
part 'ad_list_state.dart';

@injectable
class AdListCubit extends BaseCubit<AdListBuildable, AdListListenable> {
  AdListCubit(this.adRepository, this.commonRepository)
      : super(AdListBuildable()) {
    getController();
  }

  void initiallyDate(String? keyWord, AdListType adListType) {
    build((buildable) => buildable.copyWith(keyWord: keyWord ?? ""));
  }

  static const _pageSize = 20;
  final AdRepository adRepository;
  final CommonRepository commonRepository;

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

  PagingController<int, AdModel> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, AdModel>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList =
        await adRepository.getHomeAds(pageKey, _pageSize, buildable.keyWord);
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

  Future<void> addFavorite(AdModel adModel) async {
    try {
      await commonRepository.addFavorite(
          adType: adModel.adRouteType.name, id: adModel.id);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        invoke(AdListListenable(AdListEffect.navigationToAuthStart));
      }
    }
  }
}
