import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/device/active_device_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.userRepository) : super(PageState()) {
    getController();
  }

  final UserRepository userRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, ActiveDeviceResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, ActiveDeviceResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await userRepository.getActiveDevice();
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
      await userRepository.removeActiveResponse(response);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
