import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/models/ad.dart';
import '../../../../domain/models/ad_detail.dart';
import '../../../../domain/repositories/ad_repository.dart';
import '../../../../domain/repositories/cart_repository.dart';
import '../../../../domain/repositories/favorite_repository.dart';

part 'ad_detail_cubit.freezed.dart';
part 'ad_detail_state.dart';

@injectable
class AdDetailCubit extends BaseCubit<AdDetailBuildable, AdDetailListenable> {
  AdDetailCubit(this._adRepository, this.favoriteRepository, this.cartRepository)
      : super(AdDetailBuildable());

  final AdRepository _adRepository;
  final FavoriteRepository favoriteRepository;
  final CartRepository cartRepository;

  void setAdId(int adId) {
    build((buildable) => buildable.copyWith(adId: adId));
    getDetailResponse();
  }

  Future<void> getDetailResponse() async {
    try {
      var response = await _adRepository.getAdDetail(buildable.adId!);
      build((buildable) => buildable.copyWith(
          adDetail: response,
          isPhoneVisible: false,
          isAddCart: response?.isAddCart ?? false));
    } on DioException catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
    getSimilarAds();
  }

  Future<void> setPhotoView() async{
    build((buildable) => buildable.copyWith(isPhoneVisible: true));
  }

  Future<void> addFavorite() async {
    try {
      final ad = buildable.adDetail;
      if (!(ad?.favorite ?? false)) {
        final backendId =
            await favoriteRepository.addFavorite(buildable.adDetail!.toMap());
        build((buildable) => buildable.copyWith(
            adDetail: buildable.adDetail
              ?..favorite = true
              ..backendId = backendId,
            isAddCart: false));
      } else {
        await favoriteRepository.removeFavorite(buildable.adDetail!.toMap());
        build((buildable) => buildable.copyWith(
            adDetail: buildable.adDetail?..favorite = false));
      }
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> similarAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.similarAds.indexOf(ad);
        final item = buildable.similarAds.elementAt(index);
        buildable.similarAds.insert(
            index,
            item
              ..favorite = true
              ..backendId = backendId);
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.similarAds.indexOf(ad);
        final item = buildable.similarAds.elementAt(index);
        buildable.similarAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
    }
  }

  Future<void> addCart() async {
    try {
      final resultId =
          await cartRepository.addCart(buildable.adDetail!.toMap());
      build((buildable) => buildable.copyWith(isAddCart: true));
      display.success("mahsulot savatchaga qo'shildi");
    } on DioException catch (e) {
      display.error("xatlik yuz berdi");
      log.e(e.toString());
    }
  }

  Future<void> getSimilarAds() async {
    try {
      final similarAds = await _adRepository.getSimilarAds(buildable.adId ?? 0);
      build((buildable) => buildable.copyWith(
          similarAds: similarAds, similarAdsState: AppLoadingState.success));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(similarAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}
