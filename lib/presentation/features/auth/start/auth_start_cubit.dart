import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';
import 'package:url_launcher/url_launcher.dart';

part 'auth_start_cubit.freezed.dart';
part 'auth_start_state.dart';

@injectable
class AuthStartCubit extends BaseCubit<AuthStartState, AuthStartEvent> {
  AuthStartCubit(this._authRepository) : super(AuthStartState());

  final AuthRepository _authRepository;

  void setPhone(String phone) {
    logger.i(phone);
    updateState((state) => state.copyWith(
          phone: phone,
          validation: phone.length >= 9,
        ));
  }

  void validation() async {
    _authRepository
        // .phoneVerification(states.phone.clearPhoneWithCode())
        .phoneCheck(states.phone.clearPhoneWithCode())
        .initFuture()
        .onStart((){
          updateState((state) => state.copyWith(loading: true));
        })
        .onSuccess((data){
          if (data.data.is_registered == true) {
            emitEvent(AuthStartEvent(AuthStartEventType.onOpenLogin, phone: states.phone));
          } else {
            emitEvent(AuthStartEvent(AuthStartEventType.onOpenRegister, phone: states.phone));
          }
        })
        .onError((error){
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished((){
          updateState((state) => state.copyWith(loading: false));
        })
        .executeFuture();
  }

  Future<EImzoModel?> edsAuth() async {
    // updateState((state) => state.copyWith(loading: true));
    try {
      final result = await _authRepository.edsAuth();
      return result;
    } catch (e) {
      emitEvent(AuthStartEvent(AuthStartEventType.onEdsLoginFailed));
    } finally {
      // updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> edsCheckStatus(String documentId) async {
    Timer? _timer;
    int _elapsedSeconds = 0;
    try {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        if (_elapsedSeconds < 90) {
          final result =
              await _authRepository.edsCheckStatus(documentId, _timer);
          logger.e(result);
          if (result == 1) {
            edsSignIn(documentId);
          }
          _elapsedSeconds += 3;
        } else {
          _timer?.cancel();
        }
      });
    } catch (e) {
      emitEvent(AuthStartEvent(AuthStartEventType.onEdsLoginFailed));
    }
  }

  Future<void> edsSignIn(String documentId) async {
    updateState((state) => state.copyWith(loading: true));
    try {
      logger.e(documentId);
      await _authRepository.edsSignIn(documentId);
      edsSignIn(documentId).whenComplete(() {
        emitEvent(AuthStartEvent(AuthStartEventType.onOpenHome));
      });
    } catch (e) {
      logger.w("sign with eds error = $e");
      updateState((state) => state.copyWith(loading: false));
      emitEvent(AuthStartEvent(AuthStartEventType.onEdsLoginFailed));
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
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
