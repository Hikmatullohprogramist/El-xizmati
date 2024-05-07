import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository) : super(PageState());

  final AuthRepository _authRepository;

  void setPhone(String phone) {
    logger.i(phone);
    updateState((state) => state.copyWith(
          phone: phone,
          validation: phone.length >= 9,
        ));
  }

  void validation() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      var response =
          await _authRepository.authStart(states.phone.clearPhoneWithCode());
      if (response.data.is_registered == true) {
        emitEvent(
          PageEvent(PageEventType.onOpenLogin, phone: states.phone),
        );
      } else {
        emitEvent(
          PageEvent(PageEventType.onOpenConfirm, phone: states.phone),
        );
      }
    } catch (e) {
      snackBarManager.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<EImzoModel?> edsAuth() async {
    // updateState((state) => state.copyWith(loading: true));
    try {
      final result = await _authRepository.edsAuth();
      return result;
    } catch (e) {
      emitEvent(PageEvent(PageEventType.onEdsLoginFailed));
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
          final result = await _authRepository.edsCheckStatus(documentId, _timer);
          logger.e(result);
          if (result == 1) {
            // await Future.delayed(Duration(seconds: 2));
            edsSignIn(documentId);
          }
          _elapsedSeconds += 3;
        } else {
          _timer?.cancel();
        }
      });
    } catch (e) {
      emitEvent(PageEvent(PageEventType.onEdsLoginFailed));
    }
  }

  Future<void> edsSignIn(String documentId) async {
    updateState((state) => state.copyWith(loading: true));
    try {
      logger.e(documentId);
      await _authRepository.edsSignIn(documentId);
      edsSignIn(documentId).whenComplete(() {
        emitEvent(PageEvent(PageEventType.onOpenHome));
      });
    } catch (e) {
      logger.w("sign with eds error = $e");
      updateState((state) => state.copyWith(loading: false));
      emitEvent(PageEvent(PageEventType.onEdsLoginFailed));
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
