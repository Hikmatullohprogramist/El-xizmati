import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/domain/models/otp/otp_confirm_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/extension_message_exts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'otp_confirmation_cubit.freezed.dart';
part 'otp_confirmation_state.dart';

@injectable
class OtpConfirmationCubit
    extends BaseCubit<OtpConfirmationState, OtpConfirmationEvent> {
  final AuthRepository _authRepository;

  OtpConfirmationCubit(
    this._authRepository,
  ) : super(OtpConfirmationState());

  Timer? _timer;

  void setInitialParams(
    String phone,
  ) {
    updateState(
      (state) => state.copyWith(
        phone: phone,
        otpCode: "",
      ),
    );
  }

  // Future<String> getAppSignature() async {
  //   final signature = await SmsAutoFill().getAppSignature;
  //   return signature;
  // }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (states.timerTime > 0) {
        updateState((state) => state.copyWith(
              timerTime: state.timerTime - 1,
            ));
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void setEnteredOtpCode(String otpCode) {
    updateState((state) => state.copyWith(otpCode: otpCode));
  }

  void resendCode() {}

  void confirmCode() {
    if (OtpConfirmType.forRegister == state.state?.otpConfirmType) {
      registerConfirmOtpCode();
    } else {
      confirmOtpCodeForResetPassword();
    }
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

  Future<void> registerConfirmOtpCode() async {
    _authRepository
        .registerConfirmOtpCode(
          states.phone.clearPhoneWithCode(),
          states.sessionToken,
          states.otpCode,
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isConfirmLoading: true));
        })
        .onSuccess((data) {
          _timer?.cancel();

          updateState((state) => state.copyWith(
                isConfirmLoading: false,
                secretKey: data,
              ));
          emitEvent(OtpConfirmationEvent(
            OtpConfirmationEventType.onOpenIdentityVerification,
          ));
        })
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(isConfirmLoading: false));
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> confirmOtpCodeForResetPassword() async {
    _authRepository
        .confirmResetOtpCode(states.phone.clearPhoneWithCode(), states.otpCode)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isConfirmLoading: true));
        })
        .onSuccess((data) async {
          _timer?.cancel();
          updateState((state) => state.copyWith(isConfirmLoading: false));
          emitEvent(OtpConfirmationEvent(
              OtpConfirmationEventType.onOpenResetPassword));
        })
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(isConfirmLoading: false));
          emitEvent(OtpConfirmationEvent(
              OtpConfirmationEventType.onOpenResetPassword));
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
