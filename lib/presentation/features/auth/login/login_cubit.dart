import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, LoginEvent> {
  LoginCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(const LoginState());

  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  void setInitialParams(String phone) {
    updateState((state) => state.copyWith(
          phone: phone.clearPhoneWithoutCode(),
        ));
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
          updateState((state) => state.copyWith(isRequestSending: false));
          emitEvent(LoginEvent(LoginEventType.onOpenHome));
        })
        .onError((error) {
          logger.w("login onError  ${error.toString()}");
          updateState((state) => state.copyWith(isRequestSending: false));
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> forgetPassword() async {
    try {
      await _authRepository.requestResetOtpCode(states.phone.clearPhoneWithCode());
      emitEvent(LoginEvent(LoginEventType.onOpenResetPassword));
    } catch (e) {
      logger.w(e);
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
      emitEvent(LoginEvent(LoginEventType.onOpenHome));
    }
  }
}
