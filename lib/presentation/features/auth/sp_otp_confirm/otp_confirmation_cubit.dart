import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/domain/models/otp/otp_confirm_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

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
        phone: phone
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (states.timerTime > 0) {
        updateState((state) => state.copyWith(timerTime: state.timerTime - 1));
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      emitEvent(OtpConfirmationEvent(OtpConfirmationEventType.onOpenResetPassword));
    }
  }

  void setEnteredOtpCode(String otpCode) {
    updateState((state) => state.copyWith(otpCode: otpCode));
  }

  void setCode(String code) {updateState((state) => state.copyWith(otpCode: code));}

  Future<void> sendConfirmOtpCode() async {
    _authRepository
        .registerConfirmOtpCode(
          "+${states.phone.clearPhoneWithCode()}",
          states.otpCode)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isConfirmLoading: true));
        })
        .onSuccess((data) {
          _timer?.cancel();
          updateState((state) => state.copyWith(isConfirmLoading: false));
          if((data?.is_created??false)){

            emitEvent(OtpConfirmationEvent(OtpConfirmationEventType.onOpenHome));
          }else{
            emitEvent(OtpConfirmationEvent(OtpConfirmationEventType.onOpenRegistrationRoute));
          }
        }
        )
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(isConfirmLoading: false));
         stateMessageManager.showErrorBottomSheet("Tasdiqlash kodi mos kelmadi");
        })
        .onFinished(() {})
        .executeFuture();
  }

}
