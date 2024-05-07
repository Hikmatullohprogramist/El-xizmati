import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/social_account_mapper.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social_account/social_account_info.dart';
import 'package:url_launcher/url_launcher.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository, this._userRepository) : super(PageState()) {
    getActiveDeviceController();
    getSocialAccountInfo();
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> getUser() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));

      await Future.wait([
        getRegions(),
        getDistrict(),
        getStreets(),
      ]);

      updateState((state) => state.copyWith(isLoading: false));
    } catch (e) {
      logger.e(e.toString());

      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getUserInformation() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));

      final response = await _userRepository.getUser();
      List<SocialAccountInfo>? instagram = response.socials
          ?.where((element) => element.type == "INSTAGRAM")
          .map((e) => e.toMap())
          .toList();

      var telegram = response.socials
          ?.where((element) => element.type == "TELEGRAM")
          .map((e) => e.toMap())
          .toList();

      var facebook = response.socials
          ?.where((element) => element.type == "FACEBOOK")
          .map((e) => e.toMap())
          .toList();

      var youtube = response.socials
          ?.where((element) => element.type == "YOUTUBE")
          .map((e) => e.toMap())
          .toList();
      if (telegram!.isNotEmpty) {
        updateState((state) => state.copyWith(
              instagramInfo: instagram?[0],
              telegramInfo: telegram?[0],
              facebookInfo: facebook?[0],
              youtubeInfo: youtube?[0],
            ));
      }
      updateState(
        (state) => state.copyWith(
          isLoading: false,
          userName: (response.full_name ?? "*"),
          fullName: response.full_name ?? "*",
          phoneNumber: response.mobile_phone ?? "*",
          email: response.email ?? "*",
          photo: response.photo ?? "",
          biometricInformation:
              "${response.passport_serial ?? ""} ${response.passport_number ?? ""}",
          brithDate: response.birth_date ?? "*",
          districtName: (response.district_id ?? "*").toString(),
          isRegistered: response.is_registered ?? false,
          regionId: response.region_id,
          districtId: response.district_id,
          gender: response.gender ?? "*",
          streetId: response.mahalla_id,
          savedSmsState: response.message_type.toString().contains("SMS"),
          savedEmailState: response.message_type.toString().contains("EMAIL"),
          savedTelegramState:
              response.message_type.toString().contains("TELEGRAM"),
          actualSmsState: response.message_type.toString().contains("SMS"),
          actualEmailState: response.message_type.toString().contains("EMAIL"),
          actualTelegramState:
              response.message_type.toString().contains("TELEGRAM"),
        ),
      );
      logger.e("getUserInformation onSuccess");
      await getUser();
    } on DioException catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isLoading: false));
      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
    } catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList = response.where((e) => e.id == states.regionId);
    if (regionList.isNotEmpty) {
      updateState((state) =>
          state.copyWith(regionName: regionList.first.name, isLoading: false));
    } else {
      updateState(
        (state) => state.copyWith(regionName: "topilmadi", isLoading: false),
      );
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    updateState((state) => state.copyWith(
        districtName: response
            .where((element) => element.id == states.districtId)
            .first
            .name));
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId;
      final response =
          await _userRepository.getNeighborhoods(districtId ?? 1419);
      updateState((state) => state.copyWith(
          streetName: response
              .where((element) => element.id == states.streetId)
              .first
              .name,
          isLoading: false));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getSocialAccountInfo() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));
      logger.e("getUserInformation onLoading");
      final response = await _userRepository.getUser();
      var instagram = response.socials
          ?.where((element) => element.type == "INSTAGRAM")
          .map((e) => e.toMap())
          .toList();
      var telegram = response.socials
          ?.where((element) => element.type == "TELEGRAM")
          .map((e) => e.toMap())
          .toList();
      var facebook = response.socials
          ?.where((element) => element.type == "FACEBOOK")
          .map((e) => e.toMap())
          .toList();
      var youtube = response.socials
          ?.where((element) => element.type == "YOUTUBE")
          .map((e) => e.toMap())
          .toList();
      if (instagram != null && telegram != null && facebook != null) {
        updateState(
          (state) => state.copyWith(
            instagramInfo: instagram[0],
            telegramInfo: telegram[0],
            facebookInfo: facebook[0],
            youtubeInfo: youtube?[0],
          ),
        );
      }

      logger.e("getUserInformation onSuccess");
      await getUser();
    } on DioException catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isLoading: false));
      if (e.response?.statusCode == 401) {
        logOut();
      }
    } catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  changeSmsNotificationState() {
    updateState((state) => state.copyWith(
          actualSmsState: !states.actualSmsState,
        ));
  }

  changeEmailNotificationState() {
    updateState((state) => state.copyWith(
          actualEmailState: !states.actualEmailState,
        ));
  }

  changeTelegramNotificationState() {
    updateState((state) => state.copyWith(
          actualTelegramState: !states.actualTelegramState,
        ));
  }

  bool hasNotSavedNotificationChanges() {
    return states.savedSmsState != states.actualSmsState ||
        states.savedEmailState != states.actualEmailState ||
        states.savedTelegramState != states.actualTelegramState;
  }

  setInstagramSocial(String status) {
    if (states.instagramInfo?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          instagramInfo: states.instagramInfo?..status = status,
        ));
  }

  setTelegramSocial(String status) {
    if (states.telegramInfo?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          telegramInfo: states.instagramInfo?..status = status,
        ));
  }

  setFacebookSocial(String status) {
    if (states.facebookInfo?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          facebookInfo: state.facebookInfo?..status = status,
        ));
  }

  setYoutubeSocial(String status) {
    if (states.youtubeInfo?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          youtubeInfo: state.youtubeInfo?..status = status,
        ));
  }

  Future<void> setMessageType() async {
    var sources = "";
    if (states.actualSmsState) {
      sources = "SMS";
    }
    if (states.actualEmailState) {
      sources = "$sources,EMAIL";
    }
    if (states.actualTelegramState) {
      sources = "$sources,TELEGRAM";
    }
    updateState((state) => state.copyWith(isUpdatingNotification: true));
    try {
      logger.w(sources);
      await _userRepository.updateNotificationSources(sources: sources);

      updateState((state) => state.copyWith(
            isUpdatingNotification: false,
            savedSmsState: state.actualSmsState,
            savedEmailState: state.actualEmailState,
            savedTelegramState: state.actualTelegramState,
          ));

      emitEvent(PageEvent(PageEventType.onSuccessUpdateNotification));
    } catch (error) {
      updateState((state) => state.copyWith(isUpdatingNotification: false));
      emitEvent(PageEvent(PageEventType.onFailedUpdateNotification));
    }
  }

  Future<void> updateSocialAccountInfo() async {
    var socials = [
      states.instagramInfo!,
      states.telegramInfo!,
      states.facebookInfo!,
      states.youtubeInfo!,
    ];
    updateState((state) => state.copyWith(isUpdatingSocialInfo: true));
    try {
      await _userRepository.updateSocialAccountInfo(socials: socials);
      updateState((state) => state.copyWith(isUpdatingSocialInfo: false));
    } catch (error) {
      updateState((state) => state.copyWith(isUpdatingSocialInfo: false));
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

  Future<void> getActiveDeviceController() async {
    try {
      final controller = states.controller ?? getActiveDevices(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      snackBarManager.error(e.toString());
    } finally {
      logger.i(states.controller);
    }
  }

  PagingController<int, ActiveSession> getActiveDevices({
    required int status,
  }) {
    final controller = PagingController<int, ActiveSession>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        final items = await _userRepository.getActiveDevice();
        if (items.length <= 1000) {
          if (items.length > 2) {
            controller.appendLastPage(items.sublist(0, 2));
          } else {
            controller.appendLastPage(items);
          }
          logger.i(states.controller);
          return;
        }
        controller.appendPage(items, pageKey + 1);
        logger.i(states.controller);
      },
    );
    return controller;
  }

  Future<void> removeActiveDevice(ActiveSession session) async {
    try {
      await _userRepository.removeActiveResponse(session);
      states.controller?.itemList?.remove(session);
      states.controller?.notifyListeners();
    } catch (error) {
      logger.e(error.toString());
    }
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
    emitEvent(PageEvent(PageEventType.onLogout));
  }
}
