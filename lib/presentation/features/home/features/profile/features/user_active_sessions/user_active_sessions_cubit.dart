import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_active_sessions_cubit.freezed.dart';
part 'user_active_sessions_state.dart';

@Injectable()
class UserActiveSessionsCubit
    extends BaseCubit<UserActiveSessionsState, UserActiveSessionsEvent> {
  final UserRepository _userRepository;

  UserActiveSessionsCubit(this._userRepository)
      : super(UserActiveSessionsState()) {
    getController();
  }

  Future<void> getController() async {
    final controller = states.controller ?? getAdsController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
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
        _userRepository
            .getActiveSessions()
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 1000) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              logger.e(error);
              controller.error = error;
            })
            .onFinished(() {})
            .executeFuture();
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
