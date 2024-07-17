import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/notification_repository.dart';
import 'package:onlinebozor/domain/models/notification/notification.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'notification_list_cubit.freezed.dart';
part 'notification_list_state.dart';

@injectable
class NotificationListCubit
    extends BaseCubit<NotificationListState, NotificationListEvent> {
  final NotificationRepository _notificationRepository;

  NotificationListCubit(
    this._notificationRepository,
  ) : super(NotificationListState()) {
    initController();
  }

  Future<void> initController() async {
    try {
      final controller = states.controller ?? getController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  PagingController<int, AppNotification> getController({required int status}) {
    final controller = PagingController<int, AppNotification>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );

    controller.addPageRequestListener(
      (pageKey) {
        _notificationRepository
            .getAppNotifications(
              page: pageKey,
              limit: 20,
            )
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length < 20) {
                controller.appendLastPage(data);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              if (error is NotAuthorizedException) {
                controller.appendLastPage([]);
                return;
              }

              controller.error = error;
              if (error.isRequiredShowError) {
                stateMessageManager
                    .showErrorBottomSheet(error.localizedMessage);
              }
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }

  void markAsRead(AppNotification notification) {
    if(notification.isRead) return;

    _notificationRepository
        .readAppNotification(notification)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          final controller = states.controller;
          if (controller == null || controller.itemList == null) return;

          final itemList = controller.itemList;
          if (itemList == null) return;

          final index = itemList.indexWhere((e) => e.id == notification.id);
          final item = index >= 0 ? itemList.elementAt(index) : null;

          if (item != null) {
            controller.itemList?.removeAt(index);
            controller.itemList?.insert(index, item..status = "READ");
            controller.notifyListeners();
          }
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(Strings.commonErrorMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
