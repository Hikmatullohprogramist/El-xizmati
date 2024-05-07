import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/auth_confirm_page.dart';
import 'package:url_launcher/url_launcher.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(PageState());

  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;
  Timer? _timer;

  void setInitialParams(String phone, ConfirmType confirmType) {
    updateState(
      (state) => state.copyWith(
        phone: phone,
        confirmType: confirmType,
        code: "",
      ),
    );
  }

  // Future<String> getAppSignature() async {
  //   final signature = await SmsAutoFill().getAppSignature;
  //   return signature;
  // }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateState(
        (state) => state.copyWith(timerTime: state.timerTime - 1),
      );
      if (states.timerTime == 0) stopTimer();
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void setCode(String code) {
    updateState((state) => state.copyWith(code: code));
  }

  void resendCode() {}

  void confirmCode() {
    if (ConfirmType.confirm == state.state?.confirmType) {
      phoneConfirmByCode();
    } else {
      recoveryPhoneConfirmByCode();
    }
  }

  launchURLApp() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/page/privacy");
      await launchUrl(url);
    } catch (e) {
      snackBarManager.error(
          e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> phoneConfirmByCode() async {
    updateState((state) => state.copyWith(isConfirmLoading: true));
    try {
      await _authRepository.confirm(states.phone.clearPhoneWithCode(), states.code);
      _timer?.cancel();
      sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.setPassword));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      snackBarManager.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(isConfirmLoading: false));
    }
  }

  Future<void> recoveryPhoneConfirmByCode() async {
    updateState((state) => state.copyWith(isConfirmLoading: true));
    try {
      await _authRepository.recoveryConfirm(
          states.phone.clearPhoneWithCode(), states.code);
      _timer?.cancel();
      await sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.setPassword));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      emitEvent(PageEvent(PageEventType.setPassword));
      snackBarManager.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(isConfirmLoading: false));
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      snackBarManager.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.setPassword));
    }
  }
}
