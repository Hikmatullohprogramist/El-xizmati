import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../domain/models/ad_detail.dart';
import '../../../../../../../domain/repositories/ad_repository.dart';
import '../../../../../../../domain/repositories/cart_repository.dart';
import '../../../../../../../domain/repositories/favorite_repository.dart';
import '../../../../../../../domain/repositories/state_repository.dart';
import '../../../../../../../domain/repositories/user_repository.dart';

part 'order_create_cubit.freezed.dart';
part 'order_create_state.dart';

@Injectable()
class OrderCreateCubit
    extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit(this._adRepository, this._cartRepository,
      this.favoriteRepository, this.stateRepository, this.userRepository)
      : super(const OrderCreateBuildable());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;
  final StateRepository stateRepository;
  final UserRepository userRepository;

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
        await _cartRepository.removeCart(buildable.adDetail!.toMap());
        invoke(OrderCreateListenable(OrderCreateEffect.delete));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite() async {
    try {
      if (!buildable.adDetail!.favorite) {
        await favoriteRepository.addFavorite(buildable.adDetail!.toMap());
        display.success("Success");
      } else {
        await favoriteRepository.removeFavorite(buildable.adDetail!.toMap());
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
      final isLogin = await stateRepository.isLogin() ?? false;
      final isFullRegister = await userRepository.isFullRegister();
      if (isLogin) {
        if (isFullRegister) {
          if (buildable.paymentId > 0) {
            await _cartRepository.orderCreate(
                productId: buildable.adId ?? -1,
                amount: buildable.count,
                paymentTypeId: buildable.paymentId,
                tin: buildable.adDetail?.sellerTin ?? -1);
            await _cartRepository.removeOrder(
                tin: buildable.adDetail?.sellerTin ?? -1);
            invoke(OrderCreateListenable(OrderCreateEffect.delete));
          } else {
            display.error("to'lov turi tanlanmagan");
          }
        } else {
          display.error("To'liq ro'yxatdan o'tilmagan");
        }
      } else {
        invoke(OrderCreateListenable(OrderCreateEffect.navigationAuthStart));
      }
    } catch (e) {
      display.error("error");
    }
  }
}
