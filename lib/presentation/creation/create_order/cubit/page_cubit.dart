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

part 'page_cubit.freezed.dart';
part 'page_state.dart';

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

  Future<void> getDetailResponse() async {
    try {
      final response = await _adRepository.getAdDetail(states.adId!);
      final paymentList =
          response?.paymentTypes?.map((e) => e.id ?? -1).toList() ??
              List.empty();
      updateState((state) => state.copyWith(
          adDetail: response,
          favorite: response?.favorite ?? false,
          paymentType: paymentList));
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }

  void setPaymentType(int typeId) {
    updateState((state) => state.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    try {
      if (states.adId != null) {
        await _cartRepository.removeCart(states.adDetail!.toMap());
        emitEvent(PageEvent(PageEventType.onBackAfterRemove));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> changeFavorite() async {
    try {
      if (states.adDetail?.favorite == true) {
        await favoriteRepository.removeFromFavorite(states.adDetail!.adId);
      } else {
        await favoriteRepository.addToFavorite(states.adDetail!.toMap());
      }

      final favorite = !states.favorite;
      updateState((state) => state.copyWith(favorite: favorite));
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
          if (states.paymentId > 0) {
            await _cartRepository.orderCreate(
              productId: states.adId ?? -1,
              amount: states.count,
              paymentTypeId: states.paymentId,
              tin: states.adDetail?.sellerTin ?? -1,
            );
            await _cartRepository.removeOrder(
              tin: states.adDetail?.sellerTin ?? -1,
            );
            emitEvent(PageEvent(PageEventType.onOpenAfterCreation));
          } else {
            display.error("to'lov turi tanlanmagan");
          }
        } else {
          display.error("To'liq ro'yxatdan o'tilmagan");
        }
      } else {
        emitEvent(PageEvent(PageEventType.onOpenAuthStart));
      }
    } catch (e) {
      display.error("error");
    }
  }
}
