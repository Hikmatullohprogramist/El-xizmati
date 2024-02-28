import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../data/repositories/auth_repository.dart';
import '../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../data/responses/device/active_device_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._authRepository,
    this._userRepository,
  ) : super(PageState()) {
    // getActiveDeviceController();
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> getUser() async {
    try {
      build((buildable) => buildable.copyWith(isLoading: true));

      await Future.wait([
        getRegions(),
        getDistrict(),
        getStreets(),
      ]);

      build((buildable) => buildable.copyWith(isLoading: false));
    } catch (e) {
      log.e(e.toString());

      build((buildable) => buildable.copyWith(isLoading: false));
    }
  }

  Future<void> getUserInformation() async {
    try {
      build((buildable) => buildable.copyWith(isLoading: true));

      log.e("getUserInformation onLoading");

      final response = await _userRepository.getFullUserInfo();
      build(
        (buildable) => buildable.copyWith(
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
        ),
      );

      log.e("getUserInformation onSuccess");

      await getUser();
    } on DioException catch (e) {
      log.e("getUserInformation onFailure error = ${e.toString()}");

      build((buildable) => buildable.copyWith(isLoading: false));

      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
    }
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList =
        response.where((element) => element.id == buildable.regionId);
    if (regionList.isNotEmpty) {
      build((buildable) => buildable.copyWith(
          regionName: regionList.first.name, isLoading: false));
    } else {
      build((buildable) =>
          buildable.copyWith(regionName: "topilmadi", isLoading: false));
    }
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    build((buildable) => buildable.copyWith(
        districtName: response
            .where((element) => element.id == buildable.districtId)
            .first
            .name));
  }

  Future<void> getStreets() async {
    try {
      final districtId = buildable.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      build((buildable) => buildable.copyWith(
          streetName: response
              .where((element) => element.id == buildable.streetId)
              .first
              .name,
          isLoading: false));
    } catch (e) {
      build((buildable) => buildable.copyWith(isLoading: false));
    }
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
    invoke(ProfileViewListenable(ProfileViewEffect.navigationAuthStart));
  }

  setSmsNotification() {
    build((buildable) =>
        buildable.copyWith(smsNotification: !buildable.smsNotification));
  }

  setTelegramNotification() {
    build((buildable) => buildable.copyWith(
        telegramNotification: !buildable.telegramNotification));
  }

  setEmailNotification() {
    build((buildable) =>
        buildable.copyWith(emailNotification: !buildable.emailNotification));
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
      final controller =
          buildable.devicesPagingController ?? getActiveDevices(status: 1);
      build((buildable) =>
          buildable.copyWith(devicesPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.devicesPagingController);
    }
  }

  PagingController<int, ActiveDeviceResponse> getActiveDevices({
    required int status,
  }) {
    final adController = PagingController<int, ActiveDeviceResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.devicesPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        updateState((state) => state.copyWith(isLoading: true));
        log.d(response);
        build((buildable) => buildable.copyWith(
            regionName: regionList.first.name, isLoading: false));
      updateState((state) => state.copyWith(isLoading: false));
      updateState((state) => state.copyWith(isLoading: false));
      updateState((state) => state.copyWith(isLoading: true));
      updateState(
        (state) => state.copyWith(
      updateState((state) => state.copyWith(isLoading: false));
        response.where((element) => element.id == states.regionId);
      updateState((state) =>
          state.copyWith(regionName: regionList.first.name, isLoading: false));
      updateState(
          (state) => state.copyWith(regionName: "topilmadi", isLoading: false));
    final regionId = states.regionId;
    updateState(
      (state) => state.copyWith(
        districtName:
            response.where((e) => e.id == state.districtId).first.name,
      ),
    );
      final districtId = states.districtId;
      updateState((state) => state.copyWith(
              .where((element) => element.id == state.streetId)
      updateState((state) => state.copyWith(isLoading: false));
    emitEvent(PageEvent(PageEventType.onLogout));
    updateState(
        (state) => state.copyWith(smsNotification: !state.smsNotification));
    updateState((state) =>
        state.copyWith(telegramNotification: !state.telegramNotification));
    updateState(
        (state) => state.copyWith(emailNotification: !state.emailNotification));
      final controller = states.controller ?? getActiveDevices(status: 1);
      updateState((state) => state.copyWith(controller: controller));
      log.i(states.controller);
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);
        final adsList = await _userRepository.getActiveDevice();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(states.controller);
      },
    );
    return adController;
  }

  Future<void> removeActiveDevice(ActiveDeviceResponse response) async {
    try {
      await _userRepository.removeActiveResponse(response);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
