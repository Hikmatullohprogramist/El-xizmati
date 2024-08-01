import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/card_repositroy.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';

part 'order_creation_cubit.freezed.dart';
part 'order_creation_state.dart';

@Injectable()
class OrderCreationCubit
    extends BaseCubit<OrderCreationState, OrderCreationEvent> {

  final AdRepository _adRepository;
  final CardRepository _cardRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;
  final StateRepository _stateRepository;
  final UserOrderRepository _userOrderRepository;

  OrderCreationCubit(
    this._adRepository,
    this._cardRepository,
    this._cartRepository,
    this._favoriteRepository,
    this._stateRepository,
    this._userOrderRepository,
  ) : super(const OrderCreationState()) {
    getDepositCardBalance();
  }

  Future<void> setAdId(int adId) async {
    updateState((state) => state.copyWith(adId: adId));
    getDetailResponse();
  }

  List<String> getImages() {
    return (states.adDetail?.photos ?? List.empty(growable: true))
        .map((e) => "${Constants.baseUrlForImage}$e")
        .toList();
  }

  void increase() {
    updateState((state) => state.copyWith(count: state.count + 1));
  }

  void decrease() {
    if (states.count > 1) {
      updateState((state) => state.copyWith(count: state.count - 1));
    }
  }

  void setEnteredPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(price: priceInt));
  }

  String getProductPrice() {
    var price = states.hasRangePrice
        ? "${priceMaskFormatter.formatInt(states.adDetail?.fromPrice)} - ${priceMaskFormatter.formatInt(states.adDetail?.toPrice)}"
        : "${priceMaskFormatter.formatInt(states.adDetail!.price)}";

    return "$price ${states.adDetail!.currency.getLocalizedName()}";
  }

  String getOrderPrice() {
    var price = states.hasRangePrice
        ? states.price ?? 0
        : states.count * states.adDetail!.price;
    return "${priceMaskFormatter.formatInt(price)} ${states.adDetail!.currency.getLocalizedName()}";
  }

  Future<void> getDetailResponse() async {
    _adRepository
        .getAdDetail(states.adId!)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          // final paymentList =
          //     data?.paymentTypes?.map((e) => e.id ?? -1).toList() ?? [];
          updateState((state) => state.copyWith(
                adDetail: data,
                favorite: data?.isFavorite ?? false,
                hasRangePrice: data?.hasRangePrice() ?? false,
                // paymentType: paymentList,
              ));
        })
        .onError((error) {
          logger.e(error);
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getDepositCardBalance() async {
    _cardRepository
        .getDepositCardBalance()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                depositState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                depositBalance: data.amount ?? 0.0,
                depositState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                depositState: LoadingState.error,
              ));
          if (error.isRequiredShowError) {
            stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          }
        })
        .onFinished(() {})
        .executeFuture();
  }

  void setPaymentType(int typeId) {
    updateState((state) => state.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    if (states.adId != null) return;

    _cartRepository
        .removeFromCart(states.adId!)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          emitEvent(
              OrderCreationEvent(OrderCreationEventType.onBackAfterRemove));
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> changeFavorite() async {
    try {
      if (states.adDetail?.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(states.adDetail!.adId);
      } else {
        await _favoriteRepository.addToFavorite(states.adDetail!.toAd());
      }

      final favorite = !states.favorite;
      updateState((state) => state.copyWith(favorite: favorite));
      stateMessageManager.showSuccessSnackBar("succes");
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.localizedMessage);
    }
  }

  Future<void> removeFromCartAfterOrderCreation() async {
    if (states.adId != null) return;

    _cartRepository
        .removeFromCart(states.adId!)
        .initFuture()
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> orderCreate() async {
    if (!_stateRepository.isAuthorized()) {
      emitEvent(OrderCreationEvent(OrderCreationEventType.onOpenAuthStart));
      return;
    }

    _userOrderRepository
        .orderCreate(
          adId: states.adId ?? -1,
          amount: states.count,
          paymentTypeId: states.paymentId,
          tin: states.adDetail?.seller?.tin ?? -1,
          servicePrice: states.price?.toString(),
        )
        .initFuture()
        .onStart(() {
          emitEvent(OrderCreationEvent(
            OrderCreationEventType.onCreationStarted,
          ));
          updateState((state) => state.copyWith(
                isRequestSending: true,
              ));
        })
        .onSuccess((data) async {
          await Future.delayed(Duration(seconds: 2));

          emitEvent(OrderCreationEvent(
            OrderCreationEventType.onCreationFinished,
          ));
          updateState((state) => state.copyWith(isRequestSending: false));
        })
        .onError((error) {
          logger.w("create order error = $error");
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          emitEvent(OrderCreationEvent(
            OrderCreationEventType.onCreationFailed,
          ));
          updateState((state) => state.copyWith(isRequestSending: false));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
