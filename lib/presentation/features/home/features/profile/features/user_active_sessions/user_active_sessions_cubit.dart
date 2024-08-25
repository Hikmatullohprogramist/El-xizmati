import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/user_repository.dart';
import 'package:El_xizmati/domain/models/active_sessions/active_session.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'user_active_sessions_cubit.freezed.dart';
part 'user_active_sessions_state.dart';

@Injectable()
class UserActiveSessionsCubit
    extends BaseCubit<UserActiveSessionsState, UserActiveSessionsEvent> {
  final UserRepository _userRepository;

  UserActiveSessionsCubit(this._userRepository)
      : super(UserActiveSessionsState()) {
    initController();
  }

  Future<void> initController() async {
    final controller = states.controller ?? getController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, ActiveSession> getController({required int status}) {
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

  Future<void> removeActiveSession(ActiveSession session) async {
    try {
      await _userRepository.removeActiveSession(session);
      states.controller?.itemList?.remove(session);
      states.controller?.notifyListeners();
    } catch (error) {
      logger.e(error.toString());
    }
  }
}
