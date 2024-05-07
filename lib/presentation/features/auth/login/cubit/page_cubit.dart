import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
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
      snackBarManager.error(
          e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> login() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _authRepository.login(
        states.phone.clearPhoneWithCode(),
        states.password,
      );
      sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.navigationHome));
    } on DioException catch (e, stackTrace) {
      logger.w("${e.toString()} ${stackTrace.toString()}");
      if (e.response?.statusCode == 401) {
        snackBarManager.error(
            "Kiritilgan parol xato (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      } else {
        snackBarManager.error(
            "Qayta urinib ko'ring (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      }
    } catch (e, stackTrace) {
      logger.w("${e.toString()} ${stackTrace.toString()}");
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> forgetPassword() async {
    try {
      await _authRepository.forgetPassword(states.phone.clearPhoneWithCode());
      emitEvent(PageEvent(PageEventType.navigationToConfirm));
    } catch (e) {
      logger.w(e);
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      snackBarManager.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.navigationHome));
    }
  }
}
