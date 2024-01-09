import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repositories/user_repository.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/responses/device/active_device_response.dart';

part 'user_active_device_cubit.freezed.dart';

part 'user_active_device_state.dart';

@Injectable()
class UserActiveDeviceCubit
    extends BaseCubit<UserActiveDeviceBuildable, UserActiveDeviceListenable> {
  UserActiveDeviceCubit(this.userRepository)
      : super(UserActiveDeviceBuildable()) {
    getController();
  }

  final UserRepository userRepository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.devicesPagingController ?? getAdsController(status: 1);
      build((buildable) =>
          buildable.copyWith(devicesPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.devicesPagingController);
    }
  }

  PagingController<int, ActiveDeviceResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, ActiveDeviceResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.devicesPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await userRepository.getActiveDevice();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(buildable.devicesPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.devicesPagingController);
      },
    );
    return adController;
  }

  Future<void> removeActiveDevice(ActiveDeviceResponse response) async {
    try {
      await userRepository.removeActiveResponse(response);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
