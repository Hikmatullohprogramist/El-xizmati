import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';

part 'user_active_sessions_cubit.freezed.dart';
part 'user_active_sessions_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._userRepository) : super(PageState()) {
    getController();
  }

  final UserRepository _userRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {
      logger.i(states.controller);
    }
  }

  PagingController<int, ActiveSession> getAdsController({
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
          controller.appendLastPage(items);
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
}
