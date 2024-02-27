import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../../../../common/constants.dart';
import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../data/repositories/ad_repository.dart';
import '../../../../../../../data/repositories/cart_repository.dart';
import '../../../../../../../data/repositories/favorite_repository.dart';
import '../../../../../../../data/repositories/state_repository.dart';
import '../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../domain/models/ad/ad_detail.dart';

part 'order_create_cubit.freezed.dart';

part 'order_create_state.dart';

@Injectable()
class OrderCreateCubit
    extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit(
    this._adRepository,
    this._cartRepository,
    this.favoriteRepository,
    this.stateRepository,
    this.userRepository,
  ) : super(const OrderCreateBuildable());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;
  final StateRepository stateRepository;
  final UserRepository userRepository;

  Future<void> setAdId(int adId) async {
    updateState((buildable) => buildable.copyWith(adId: adId));
    getDetailResponse();
  }

  List<String> getImages() {
    return (currentState.adDetail?.photos ?? List.empty(growable: true))
        .map((e) => "${Constants.baseUrlForImage}${e.image}")
        .toList();
  }

  void add() {
    updateState((buildable) => buildable.copyWith(count: buildable.count + 1));
  }

  void minus() {
    if (currentState.count > 1) {
      updateState((buildable) => buildable.copyWith(count: buildable.count - 1));
    }
  }

  Future<void> getDetailResponse() async {
    try {
      final response = await _adRepository.getAdDetail(currentState.adId!);
      final paymentList =
          response?.paymentTypes?.map((e) => e.id ?? -1).toList() ??
              List.empty();
      updateState((buildable) => buildable.copyWith(
          adDetail: response,
          favorite: response?.favorite ?? false,
          paymentType: paymentList));
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }

  void setPaymentType(int typeId) {
    updateState((buildable) => buildable.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    try {
      if (currentState.adId != null) {
        await _cartRepository.removeCart(currentState.adDetail!.toMap());
        emitEvent(OrderCreateListenable(OrderCreateEffect.delete));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite() async {
    try {
      if (!currentState.adDetail!.favorite) {
        await favoriteRepository.addFavorite(currentState.adDetail!.toMap());
        display.success("Success");
      } else {
        await favoriteRepository.removeFavorite(currentState.adDetail!.toMap());
      }
      final favorite = !currentState.favorite;
      updateState((buildable) => buildable.copyWith(favorite: favorite));
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
          if (currentState.paymentId > 0) {
            await _cartRepository.orderCreate(
                productId: currentState.adId ?? -1,
                amount: currentState.count,
                paymentTypeId: currentState.paymentId,
                tin: currentState.adDetail?.sellerTin ?? -1);
            await _cartRepository.removeOrder(
                tin: currentState.adDetail?.sellerTin ?? -1);
            emitEvent(OrderCreateListenable(OrderCreateEffect.delete));
          } else {
            display.error("to'lov turi tanlanmagan");
          }
        } else {
          display.error("To'liq ro'yxatdan o'tilmagan");
        }
      } else {
        emitEvent(OrderCreateListenable(OrderCreateEffect.navigationAuthStart));
      }
    } catch (e) {
      display.error("error");
    }
  }
}
