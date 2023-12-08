import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/models/ad.dart';
import '../../../../domain/models/ad_detail.dart';
import '../../../../domain/repositories/ad_repository.dart';
import '../../../../domain/repositories/cart_repository.dart';
import '../../../../domain/repositories/favorite_repository.dart';
import '../../../../domain/util.dart';

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
      build((buildable) =>
          buildable.copyWith(adDetail: response, isPhoneVisible: false));
    } on DioException catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }

  Future<void> setPhotoView() async{
    build((buildable) => buildable.copyWith(isPhoneVisible: true));
  }

  Future<void> addFavorite() async {
    try {
      final adModel = buildable.adDetail;
      if (!(adModel?.favorite ?? false)) {
        await favoriteRepository.addFavorite(Ad(
            backendId: -1,
            id: adModel?.adId ?? -1,
            name: adModel?.adName ?? "",
            price: adModel?.price ?? 0,
            currency: adModel?.currency ?? Currency.uzb,
            region: adModel?.address?.region?.name ?? "",
            district: adModel?.address?.district?.name ?? "",
            adRouteType: adModel?.adRouteType ?? AdRouteType.private,
            adPropertyStatus: adModel?.propertyStatus ?? AdPropertyStatus.fresh,
            adStatusType: adModel?.adStatusType ?? AdStatusType.standard,
            adTypeStatus: adModel?.adTypeStatus ?? AdTypeStatus.buy,
            fromPrice: adModel?.fromPrice ?? 0,
            toPrice: adModel?.toPrice ?? 0,
            categoryId: adModel?.categoryId ?? -1,
            categoryName: adModel?.categoryName ?? "",
            sellerName: adModel?.sellerFullName ?? "",
            sellerId: adModel?.sellerId ?? -1,
            photo: adModel?.photos?.first.image ?? 'xatolik ',
            isSort: -1,
            isSell: false,
            maxAmount: -1,
            favorite: false,
            isCheck: false,
            view: 0));
        build((buildable) => buildable.copyWith(
            adDetail: buildable.adDetail?..favorite = true, isAddCart: false));
      } else {
        await favoriteRepository.removeFavorite(Ad(
            backendId: -1,
            id: adModel?.adId ?? -1,
            name: adModel?.adName ?? "",
            price: adModel?.price ?? 0,
            currency: adModel?.currency ?? Currency.uzb,
            region: adModel?.address?.region?.name ?? "",
            district: adModel?.address?.district?.name ?? "",
            adRouteType: adModel?.adRouteType ?? AdRouteType.private,
            adPropertyStatus: adModel?.propertyStatus ?? AdPropertyStatus.fresh,
            adStatusType: adModel?.adStatusType ?? AdStatusType.standard,
            adTypeStatus: adModel?.adTypeStatus ?? AdTypeStatus.buy,
            fromPrice: adModel?.fromPrice ?? 0,
            toPrice: adModel?.toPrice ?? 0,
            categoryId: adModel?.categoryId ?? -1,
            categoryName: adModel?.categoryName ?? "",
            sellerName: adModel?.sellerFullName ?? "",
            sellerId: adModel?.sellerId ?? -1,
            photo: adModel?.photos?.first.image ?? 'xatolik ',
            isSort: -1,
            isSell: false,
            maxAmount: -1,
            favorite: false,
            isCheck: false,
            view: 0));
        build((buildable) => buildable.copyWith(
            adDetail: buildable.adDetail?..favorite = false));
      }
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addCart() async {
    try {
      final adModel = buildable.adDetail;
      await cartRepository.addCart(Ad(
          backendId: -1,
          id: adModel?.adId ?? -1,
          name: adModel?.adName ?? "",
          price: adModel?.price ?? 0,
          currency: adModel?.currency ?? Currency.uzb,
          region: adModel?.address?.region?.name ?? "",
          district: adModel?.address?.district?.name ?? "",
          adRouteType: adModel?.adRouteType ?? AdRouteType.private,
          adPropertyStatus: adModel?.propertyStatus ?? AdPropertyStatus.fresh,
          adStatusType: adModel?.adStatusType ?? AdStatusType.standard,
          adTypeStatus: adModel?.adTypeStatus ?? AdTypeStatus.buy,
          fromPrice: adModel?.fromPrice ?? 0,
          toPrice: adModel?.toPrice ?? 0,
          categoryId: adModel?.categoryId ?? -1,
          categoryName: adModel?.categoryName ?? "",
          sellerName: adModel?.sellerFullName ?? "",
          sellerId: adModel?.sellerId ?? -1,
          photo: adModel?.photos?.first.image ?? "",
          isSort: -1,
          isSell: false,
          maxAmount: -1,
          favorite: true,
          isCheck: false,
          view: 0));
      build((buildable) => buildable.copyWith(isAddCart: true));
      display.success("mahsulot savatchaga qo'shildi");
    } on DioException catch (e) {
      display.error("xatlik yuz berdi");
      log.e(e.toString());
    }
  }
}
