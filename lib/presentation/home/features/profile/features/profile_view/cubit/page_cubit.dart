import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social/social_network.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../data/repositories/auth_repository.dart';
import '../../../../../../../data/repositories/user_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository, this._userRepository) : super(PageState()) {
    getActiveDeviceController();
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
      log.e(e.toString());

      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getUserInformation() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));
      log.e("getUserInformation onLoading");
      final response = await _userRepository.getFullUserInfo();
     // log.w(response.socials);
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
          smsNotification: response.message_type.toString().contains("SMS"),
          telegramNotification: response.message_type.toString().contains("TELEGRAM"),
          emailNotification: response.message_type.toString().contains("EMAIL"),
          instagramSocial: SocialElement(
              type: response.socials?[0].type??"",
              link: response.socials?[0].link??"",
              status: response.socials?[0].status??"",
              isLink: false,
              id:response.socials?[0].id??0,
              tin: response.socials?[0].tin??0,
              viewNote: response.socials?[0].viewNote),
          telegramSocial: SocialElement(
              type: response.socials?[1].type??"",
              link: response.socials?[1].link??"",
              status: response.socials?[1].status??"",
              isLink: false,
              id:response.socials?[1].id??0,
              tin: response.socials?[1].tin??0,
              viewNote: response.socials?[1].viewNote),
          facebookSocial: SocialElement(
              type: response.socials?[2].type??"",
              link: response.socials?[2].link??"",
              status: response.socials?[2].status??"",
              isLink: false,
              id:response.socials?[2].id??0,
              tin: response.socials?[2].tin??0,
              viewNote: response.socials?[2].viewNote),
          youtubeSocial: SocialElement(
              type: response.socials?[3].type??"",
              link: response.socials?[3].link??"",
              status: response.socials?[3].status??"",
              isLink: false,
              id:response.socials?[3].id??0,
              tin: response.socials?[3].tin??0,
              viewNote: response.socials?[3].viewNote),
        ),
      );
      log.e("getUserInformation onSuccess");
      await getUser();
    } on DioException catch (e) {
      log.e("getUserInformation onFailure error = ${e.toString()}");

      updateState((state) => state.copyWith(isLoading: false));

      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
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
      final response = await _userRepository.getNeighborhoods(districtId ?? 1419);
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

  Future<void> getSocial() async{

  }

  Future<void> logOut() async {
    await _authRepository.logOut();
    emitEvent(PageEvent(PageEventType.onLogout));
  }

  setSmsNotification() {
    updateState(
      (state) => state.copyWith(
          smsNotification: !state.smsNotification,
          enableButton: [
            !states.enableButton[0],
            states.enableButton[1],
            states.enableButton[2]
          ]),
    );
  }

  setEmailNotification() {
    updateState(
      (state) => state.copyWith(
          emailNotification: !state.emailNotification,
          enableButton: [
            states.enableButton[0],
            !states.enableButton[1],
            states.enableButton[2]
          ]),
    );
  }

  setTelegramNotification() {
    updateState(
      (state) => state.copyWith(
          telegramNotification: !state.telegramNotification,
          enableButton: [
            states.enableButton[0],
            states.enableButton[1],
            !states.enableButton[2]
          ]),
    );
  }

  bool getEnableButton() {
    return states.enableButton.every((element) => element == false);
  }

  void clearList() {
    updateState(
      (state) => state.copyWith(enableButton: [false, false, false]),
    );
  }

  Future<bool> setMessageType(String messageType) async {
    if (states.smsNotification) {
      messageType = "SMS";
    }
    if (states.emailNotification) {
      messageType = "$messageType,EMAIL";
    }
    if (states.telegramNotification) {
      messageType = "$messageType,TELEGRAM";
    }
    updateState((state) => state.copyWith(isLoadingNotification: true));
    try {
      log.w(messageType);
      final response =
          await _userRepository.sendMessageType(messageType: messageType);
    } on DioException catch (error) {
      return false;
    } finally {
      updateState((state) => state.copyWith(isLoadingNotification: false));
    }
    return true;
  }

  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> getActiveDeviceController() async {
    try {
      final controller = states.controller ?? getActiveDevices(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, ActiveSession> getActiveDevices({
    required int status,
  }) {
    final controller = PagingController<int, ActiveSession>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        final items = await _userRepository.getActiveDevice();
        if (items.length <= 1000) {
          if (items.length > 2) {
            controller.appendLastPage(items.sublist(0, 2));
          } else {
            controller.appendLastPage(items);
          }
          log.i(states.controller);
          return;
        }
        controller.appendPage(items, pageKey + 1);
        log.i(states.controller);
      },
    );
    return controller;
  }

  Future<void> removeActiveDevice(ActiveSession session) async {
    try {
      await _userRepository.removeActiveResponse(session);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
