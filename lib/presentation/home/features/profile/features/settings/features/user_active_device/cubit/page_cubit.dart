import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';

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

  PagingController<int, ActiveSession> getAdsController({
    required int status,
  }) {
    final controller = PagingController<int, ActiveSession>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        final items = await userRepository.getActiveDevice();
        if (items.length <= 1000) {
          controller.appendLastPage(items);
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
      await userRepository.removeActiveResponse(session);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
