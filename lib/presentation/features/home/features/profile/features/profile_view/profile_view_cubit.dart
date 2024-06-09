import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/user_full/user_full_info_response.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/social_account_mapper.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/social_account/social_account_info.dart';
import 'package:onlinebozor/domain/models/street/street.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_view_cubit.freezed.dart';
part 'profile_view_state.dart';

@injectable
class ProfileViewCubit extends BaseCubit<ProfileViewState, ProfileViewEvent> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  ProfileViewCubit(
    this._authRepository,
    this._userRepository,
  ) : super(ProfileViewState()) {
    getActiveDeviceController();
    getSocialAccountInfo();
  }

  Future<void> getUser() async {
    if (states.isUserDataLoaded) return;

    _userRepository
        .getUser()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isUserLoading: true));
        })
        .onSuccess((data) {
          _saveSocials(data);

          updateState(
            (state) => state.copyWith(
              isUserLoading: false,
              isUserDataLoaded: true,
              userName: (data.full_name ?? "*"),
              fullName: data.full_name ?? "*",
              phoneNumber: data.mobile_phone ?? "*",
              email: data.email ?? "*",
              photo: data.photo ?? "",
              biometricInformation:
                  "${data.passport_serial ?? ""} ${data.passport_number ?? ""}",
              brithDate: data.birth_date ?? "*",
              districtName: (data.district_id ?? "*").toString(),
              isRegistered: data.is_registered ?? false,
              regionId: data.region_id,
              districtId: data.district_id,
              gender: data.gender ?? "*",
              streetId: data.mahalla_id,
              savedSmsState: data.message_type.toString().contains("SMS"),
              savedEmailState: data.message_type.toString().contains("EMAIL"),
              savedTelegramState:
                  data.message_type.toString().contains("TELEGRAM"),
              actualSmsState: data.message_type.toString().contains("SMS"),
              actualEmailState: data.message_type.toString().contains("EMAIL"),
              actualTelegramState:
                  data.message_type.toString().contains("TELEGRAM"),
            ),
          );
        })
        .onError((error) {
          logger.e("getUser error = ${error.toString()}");
          updateState((state) => state.copyWith(isUserLoading: false));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getRegionAndDistricts() async {
    try {
      updateState((state) => state.copyWith(isUserLoading: true));

      await Future.wait([
        getRegions(),
        getDistrict(),
        getNeighborhoods(),
      ]);

      updateState((state) => state.copyWith(isUserLoading: false));
    } catch (e) {
      logger.e(e.toString());

      updateState((state) => state.copyWith(isUserLoading: false));
    }
  }

  Future<void> getRegions() async {
    if (states.regions.isNotEmpty) return;

    final regions = await _userRepository.getRegions();
    if (regions.isNotEmpty) {
      final regionName = regions.firstIf((e) => e.id == states.regionId)?.name;
      updateState((state) => state.copyWith(
            regionName: regionName ?? "",
            regions: regions,
          ));
    }
  }

  Future<void> getDistrict() async {
    if (states.districts.isNotEmpty) return;

    final regionId = states.regionId;
    if (regionId == null) return;

    final districts = await _userRepository.getDistricts(states.regionId!);
    final name = districts.firstIf((e) => e.id == states.districtId)?.name;
    updateState((state) => state.copyWith(
          districtName: name ?? "",
          districts: districts,
        ));
  }

  Future<void> getNeighborhoods() async {
    if (states.neighborhoods.isNotEmpty) return;

    final districtId = states.districtId;
    if (districtId == null) return;

    final neighborhoods = await _userRepository.getNeighborhoods(districtId);
    final name = neighborhoods.firstIf((e) => e.id == states.streetId)?.name;
    updateState((state) => state.copyWith(
          neighborhoodName: name ?? "",
          neighborhoods: neighborhoods,
        ));
  }

  Future<void> getSocialAccountInfo() async {
    try {
      updateState((state) => state.copyWith(isUserLoading: true));
      logger.e("getUserInformation onLoading");
      final user = await _userRepository.getUser();
      _saveSocials(user);
      logger.e("getUserInformation onSuccess");
      await getRegionAndDistricts();
    } on DioException catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isUserLoading: false));
      if (e.response?.statusCode == 401) {
        logOut();
      }
    } catch (e) {
      logger.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isUserLoading: false));
    }
  }

  void _saveSocials(UserResponse user) {
    final socials = user.socials;

    final instagram = socials?.firstIf((e) => e.type == "INSTAGRAM")?.toMap();
    final telegram = socials?.firstIf((e) => e.type == "TELEGRAM")?.toMap();
    final facebook = socials?.firstIf((e) => e.type == "FACEBOOK")?.toMap();
    final youtube = socials?.firstIf((e) => e.type == "YOUTUBE")?.toMap();

    updateState((state) => state.copyWith(
          instagramInfo: instagram,
          telegramInfo: telegram,
          facebookInfo: facebook,
          youtubeInfo: youtube,
        ));
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
      sources += "SMS";
    }
    if (states.actualEmailState) {
      sources += ",EMAIL";
    }
    if (states.actualTelegramState) {
      sources += ",TELEGRAM";
    }

    _userRepository
        .updateNotificationSources(sources: sources)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(isUpdatingNotification: true));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
            isUpdatingNotification: false,
            savedSmsState: state.actualSmsState,
            savedEmailState: state.actualEmailState,
            savedTelegramState: state.actualTelegramState,
          ));
      stateMessageManager
          .showSuccessSnackBar(Strings.messageChangesSavingSuccess);
    }).onError((error) {
      stateMessageManager.showErrorSnackBar(Strings.messageChangesSavingFailed);
    }).onFinished(() {
      updateState((state) => state.copyWith(isUpdatingNotification: false));
    }).executeFuture();
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
    final controller = states.controller ?? getActiveDevices(status: 1);
    updateState((state) => state.copyWith(controller: controller));
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
    emitEvent(ProfileViewEvent(ProfileViewEventType.onLogout));
  }
}
