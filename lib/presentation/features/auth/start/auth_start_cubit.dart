import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/data/repositories/eds_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/extension_message_exts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_start_cubit.freezed.dart';
part 'auth_start_state.dart';

@injectable
class AuthStartCubit extends BaseCubit<AuthStartState, AuthStartEvent> {
  final AuthRepository _authRepository;
  final EdsRepository _edsRepository;

  AuthStartCubit(
    this._authRepository,
    this._edsRepository,
  ) : super(AuthStartState());

  void setPhone(String phone) {
    logger.i(phone);
    updateState((state) => state.copyWith(
          phone: phone,
          validation: phone.length >= 9,
        ));
  }

  Future<void> authSendSMSCode() async {
    _authRepository.authSmSCode(states.phone.clearPhoneWithCode()).initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(loading: true));})
        .onSuccess((data) {
      emitEvent(AuthStartEvent(AuthStartEventType.onOTPConfirm,phone: states.phone));
        }).onError((error) {
      stateMessageManager.showErrorBottomSheet(error.localizedMessage);
    }).onFinished(() {
      updateState((state) => state.copyWith(loading: false));
    }).executeFuture();
  }


  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
