import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/responses/e_imzo_response/e_imzo_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState());

  final AuthRepository _repository;



  void setPhone(String phone) {
    log.i(phone);
    updateState((state) => state.copyWith(
          phone: phone,
          validation: phone.length >= 9,
        ));
  }

  void validation() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      var response =
          await _repository.authStart(states.phone.clearPhoneNumberWithCode());
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
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<EImzoModel?> loginWithEImzo() async {
    // updateState((state) => state.copyWith(loading: true));
    try {
      final result = await _repository.eImzoLogin();
      return result;
    } catch (e) {
      emitEvent(PageEvent(PageEventType.onEdsLoginFailed));
    } finally {
      // updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> checkStatusEImzo(String documentId) async {
    Timer? _timer;
    int _elapsedSeconds = 0;
    try {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        if (_elapsedSeconds < 90) {
          final result = await _repository.eImzoLoginCheck(documentId, _timer);
          log.e(result);
          if (result == 1) {
            // await Future.delayed(Duration(seconds: 2));
            getUserByEImzo(documentId);
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

  Future<void> getUserByEImzo(String documentId) async {
    updateState((state) => state.copyWith(loading: true));
    try {
      log.e(documentId);
      var res = await _repository.getUserByEImzo(documentId);
      if (res.status == 200) {
        getUserByEImzo(documentId).whenComplete(() {
          emitEvent(
            PageEvent(PageEventType.onOpenHome),
          );
        });
      }
    } catch (e) {
      updateState((state) => state.copyWith(loading: false));
      emitEvent(
        PageEvent(PageEventType.onEdsLoginFailed),
      );
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
