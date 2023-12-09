import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/util.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../domain/models/ad.dart';
import '../../../../domain/repositories/ad_repository.dart';
import '../../../../domain/repositories/common_repository.dart';
import '../../../../domain/repositories/favorite_repository.dart';

part 'ad_list_cubit.freezed.dart';
part 'ad_list_state.dart';

@injectable
class AdListCubit extends BaseCubit<AdListBuildable, AdListListenable> {
  AdListCubit(this.adRepository, this.commonRepository, this.favoriteRepository)
      : super(AdListBuildable());

  void setInitiallyDate(String? keyWord, AdListType adListType, int? sellerTin) {
    build((buildable) => buildable.copyWith(
        adsPagingController: null,
        keyWord: keyWord ?? "",
        sellerTin: sellerTin,
        adListType: adListType));
    getController();
  }

  static const _pageSize = 20;
  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    }on DioException  catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        List<Ad> adsList;
        switch (buildable.adListType) {
          case AdListType.list:
            adsList = await adRepository.getHomeAds(
                pageKey, _pageSize, buildable.keyWord);
          case AdListType.seller:
            adsList =
                await adRepository.getSellerAds(buildable.sellerTin ?? -1);
          case AdListType.similar:
            adsList = await adRepository.getHomeAds(
                pageKey, _pageSize, buildable.keyWord);
          case AdListType.popularCategoryProduct:
            adsList = await adRepository.getHomeAds(
                pageKey, _pageSize, buildable.keyWord);
        }
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

  Future<void> addFavorite(Ad adModel) async {
    try {
      if (!adModel.favorite) {
        await favoriteRepository.addFavorite(adModel);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(adModel) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = true);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(adModel);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(adModel) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (e) {
      display.error("xatolik yuz  berdi");
    }
  }
}
