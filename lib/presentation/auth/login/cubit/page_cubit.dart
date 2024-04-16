import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._repository,
    this._favoriteRepository,
  ) : super(const PageState());

  final AuthRepository _repository;
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
      display.error(e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> login() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _repository.login(
        states.phone.clearPhoneWithCode(),
        states.password,
      );
      sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.navigationHome));
    } on DioException catch (e, stackTrace) {
      log.w("${e.toString()} ${stackTrace.toString()}");
      if (e.response?.statusCode == 401) {
        display.error(
            "Kiritilgan parrol xato (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      } else {
        display.error("Qayta urinib ko'ring (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      }
    } catch (e, stackTrace) {
      log.w("${e.toString()} ${stackTrace.toString()}");
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> forgetPassword() async {
    try {
      await _repository.forgetPassword(states.phone.clearPhoneWithCode());
      emitEvent(PageEvent(PageEventType.navigationToConfirm));
    } catch (e) {
      log.w(e);
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.navigationHome));
    }
  }
}
