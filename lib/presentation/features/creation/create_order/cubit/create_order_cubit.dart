import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';

part 'create_order_cubit.freezed.dart';
part 'create_order_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._adRepository,
    this._cartRepository,
    this.favoriteRepository,
    this.stateRepository,
    this.userRepository,
  ) : super(const PageState());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;
  final StateRepository stateRepository;
  final UserRepository userRepository;

  Future<void> setAdId(int adId) async {
    updateState((state) => state.copyWith(adId: adId));
    getDetailResponse();
  }

  List<String> getImages() {
    return (states.adDetail?.photos ?? List.empty(growable: true))
        .map((e) => "${Constants.baseUrlForImage}${e.image}")
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
    try {
      final response = await _adRepository.getAdDetail(states.adId!);
      final paymentList =
          response?.paymentTypes?.map((e) => e.id ?? -1).toList() ?? [];
      updateState((state) => state.copyWith(
            adDetail: response,
            favorite: response?.isFavorite ?? false,
            hasRangePrice: response?.hasRangePrice() ?? false,
            paymentType: paymentList,
          ));
    } catch (e) {
      logger.e(e.toString());
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  void setPaymentType(int typeId) {
    updateState((state) => state.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    try {
      if (states.adId != null) {
        await _cartRepository.removeFromCart(states.adId!);
        emitEvent(PageEvent(PageEventType.onBackAfterRemove));
      }
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> changeFavorite() async {
    try {
      if (states.adDetail?.isFavorite == true) {
        await favoriteRepository.removeFromFavorite(states.adDetail!.adId);
      } else {
        await favoriteRepository.addToFavorite(states.adDetail!.toMap());
      }

      final favorite = !states.favorite;
      updateState((state) => state.copyWith(favorite: favorite));
      stateMessageManager.showSuccessSnackBar("succes");
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> removeFromCartAfterOrderCreation() async {
    try {
      if (states.adId != null) {
        await _cartRepository.removeFromCart(states.adId!);
      }
    } catch (e) {
      stateMessageManager.showErrorSnackBar(e.toString());
    }
  }

  Future<void> orderCreate() async {
    if (!stateRepository.isUserLoggedIn()) {
      emitEvent(PageEvent(PageEventType.onOpenAuthStart));
      return;
    }

    _cartRepository
        .orderCreate(
          adId: states.adId ?? -1,
          amount: states.count,
          paymentTypeId: states.paymentId,
          tin: states.adDetail?.sellerTin ?? -1,
          servicePrice: states.price,
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                isRequestSending: true,
              ));
        })
        .onSuccess((data) {
          emitEvent(PageEvent(PageEventType.onOpenAfterCreation));
          updateState((state) => state.copyWith(isRequestSending: false));
        })
        .onError((error) {
          logger.w("create order error = $error");
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          updateState((state) => state.copyWith(isRequestSending: false));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
