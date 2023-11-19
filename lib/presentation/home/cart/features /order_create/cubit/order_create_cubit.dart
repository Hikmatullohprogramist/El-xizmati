import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../../../../../domain/model/ad_detail.dart';
import '../../../../../../domain/model/ad_enum.dart';
import '../../../../../../domain/model/ad_model.dart';
import '../../../../../../domain/repository/ad_repository.dart';
import '../../../../../../domain/repository/cart_repository.dart';

part 'order_create_cubit.freezed.dart';

part 'order_create_state.dart';

@Injectable()
class OrderCreateCubit
    extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit(
      this._adRepository, this._cartRepository, this.favoriteRepository)
      : super(const OrderCreateBuildable());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> setAdId(int adId) async {
    build((buildable) => buildable.copyWith(adId: adId));
    getDetailResponse();
  }

  void add() {
    build((buildable) => buildable.copyWith(count: buildable.count + 1));
  }

  void minus() {
    if (buildable.count > 1) {
      build((buildable) => buildable.copyWith(count: buildable.count - 1));
    }
  }

  Future<void> getDetailResponse() async {
    try {
      final response = await _adRepository.getAdDetail(buildable.adId!);
      final paymentList =
          response?.paymentTypes?.map((e) => e.id ?? -1).toList() ??
              List.empty();
      display.success("list length ${paymentList.length}");
      build((buildable) => buildable.copyWith(
          adDetail: response,
          favorite: response?.favorite ?? false,
          paymentType: paymentList));
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }

  void setPaymentType(int typeId) {
    build((buildable) => buildable.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    try {
      if (buildable.adId != null) {
        await _cartRepository.removeCart(buildable.adId!);
        invoke(OrderCreateListenable(OrderCreateEffect.delete));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite(AdDetail adDetail) async {
    try {
      if (!adDetail.favorite) {
        await favoriteRepository.addFavorite(AdModel(
            id: adDetail.adId,
            name: adDetail.adName ?? "",
            price: adDetail.price,
            currency: adDetail.currency,
            region: adDetail.address?.region?.name ?? "",
            district: adDetail.address?.district?.name ?? "",
            adRouteType: adDetail.adRouteType ?? AdRouteType.private,
            adPropertyStatus: adDetail.propertyStatus ?? AdPropertyStatus.fresh,
            adStatusType: adDetail.adStatusType ?? AdStatusType.standard,
            adTypeStatus: adDetail.adTypeStatus ?? AdTypeStatus.buy,
            fromPrice: adDetail.fromPrice ?? 0,
            toPrice: adDetail.toPrice ?? 0,
            categoryId: adDetail.categoryId ?? -1,
            categoryName: adDetail.categoryName ?? "",
            sellerName: adDetail.sellerFullName ?? "",
            sellerId: adDetail.sellerId ?? -1,
            photo: adDetail.photos?.first.image ?? 'xatolik ',
            isSort: -1,
            isSell: false,
            maxAmount: -1,
            favorite: true,
            isCheck: false));
        display.success("Success");
      } else {
        await favoriteRepository.removeFavorite(adDetail.adId);
      }
      final favorite = !buildable.favorite;
      build((buildable) => buildable.copyWith(favorite: favorite));
      display.success("succes");
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> orderCreate() async {
    try {
      await _cartRepository.orderCreate(
          productId: buildable.adId ?? -1,
          amount: buildable.count,
          paymentTypeId: buildable.paymentId);
      display.success("success");
      invoke(OrderCreateListenable(OrderCreateEffect.back));
    } catch (e) {
      display.error("error");
    }
  }
}
