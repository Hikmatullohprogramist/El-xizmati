import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(const PageState());

  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  void setPhone(String phone) {
    updateState((state) => state.copyWith(phone: phone, password: ""));
  }

  void setPassword(String password) {
    updateState((state) => state.copyWith(
          password: password,
        ));
  }

  launchURLApp() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/page/privacy");
      await launchUrl(url);
    } catch (e) {
      stateMessageManager.showErrorSnackBar(
          e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> login() async {
    _authRepository
        .login(states.phone.clearPhoneWithCode(), states.password)
        .initFuture()
        .onStart(() {
          logger.w("login onStart");
          updateState((state) => state.copyWith(isRequestSending: true));
        })
        .onSuccess((data) {
          logger.w("login onSuccess");
          sendAllFavoriteAds();
          emitEvent(PageEvent(PageEventType.onOpenHome));
        })
        .onError((error) {
          logger.w("login onError  ${error.toString()}");
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {
          logger.w("login onFinished");
          updateState((state) => state.copyWith(isRequestSending: false));
        })
        .executeFuture();
  }

  Future<void> forgetPassword() async {
    try {
      await _authRepository.forgetPassword(states.phone.clearPhoneWithCode());
      emitEvent(PageEvent(PageEventType.onOpenAuthConfirm));
    } catch (e) {
      logger.w(e);
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.onOpenHome));
    }
  }
}
