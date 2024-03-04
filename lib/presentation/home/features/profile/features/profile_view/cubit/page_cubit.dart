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
      final response = await _userRepository.getStreets(districtId ?? 1419);
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

  Future<void> logOut() async {
    await _authRepository.logOut();
    emitEvent(PageEvent(PageEventType.onLogout));
  }


  setSmsNotification() {
    updateState(
      (state) => state.copyWith(smsNotification: !state.smsNotification),
    );
  }

  setTelegramNotification() {
    updateState(
      (state) =>
          state.copyWith(telegramNotification: !state.telegramNotification),
    );
  }

  setEmailNotification() {
    updateState(
      (state) => state.copyWith(emailNotification: !state.emailNotification),
    );
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

  PagingController<int, ActiveDeviceResponse> getActiveDevices({
    required int status,
  }) {
    final adController = PagingController<int, ActiveDeviceResponse>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final currentDevice=await _userRepository.getCurrentDevice();
        final adsList = await _userRepository.getActiveDevice();
        if (adsList.length <= 1000) {
          adController.appendLastPage(currentDevice);
          adController.appendLastPage(adsList.sublist(0,1));
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
