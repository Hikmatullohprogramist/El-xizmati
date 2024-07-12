import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/mappers/ad_mappers.dart';
import 'package:onlinebozor/data/repositories/user_ad_repository.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'user_ad_list_cubit.freezed.dart';
part 'user_ad_list_state.dart';

@Injectable()
class UserAdListCubit extends BaseCubit<UserAdListState, UserAdListEvent> {
  UserAdListCubit(this._userAdRepository) : super(const UserAdListState());

  final UserAdRepository _userAdRepository;

  void setInitialParams(UserAdStatus userAdStatus) {
    updateState((state) => state.copyWith(userAdStatus: userAdStatus));

    getController();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  PagingController<int, UserAd> getAdsController({required int status}) {
    final controller = PagingController<int, UserAd>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );

    controller.addPageRequestListener(
      (pageKey) {
        _userAdRepository
            .getUserAds(
              limit: 20,
              page: pageKey,
              userAdStatus: states.userAdStatus,
            )
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              final adsList = data.map((e) => e.toUserAd()).toList();
              if (adsList.length < 20) {
                controller.appendLastPage(adsList);
                return;
              }
              controller.appendPage(adsList, pageKey + 1);
            })
            .onError((error) {
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

  Future<void> deactivateAd(UserAd ad) async {
    _userAdRepository
        .deactivateAd(ad.id)
        .initFuture()
        .onSuccess((data) {
          if (states.userAdStatus == UserAdStatus.ALL) {
            final index =
                states.controller?.itemList?.indexWhere((e) => e.id == ad.id) ??
                    -1;
            final item = index >= 0
                ? states.controller?.itemList?.elementAt(index)
                : null;
            if (item != null) {
              states.controller?.itemList?.removeAt(index);
              states.controller?.itemList
                  ?.insert(index, item..status = UserAdStatus.INACTIVE);
              states.controller?.notifyListeners();
            }
          } else {
            states.controller?.itemList?.remove(ad);
            states.controller?.notifyListeners();
          }

          stateMessageManager
              .showSuccessSnackBar(Strings.userAdsStatusSuccessfullyChanged);
        })
        .onError((error) {
          logger.w(error.toString());
          stateMessageManager
              .showErrorSnackBar(Strings.userAdsStatusChangingFailed);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> activateAd(UserAd ad) async {
    _userAdRepository
        .activateAd(ad.id)
        .initFuture()
        .onSuccess((data) {
          if (states.userAdStatus == UserAdStatus.ALL) {
            final index =
                states.controller?.itemList?.indexWhere((e) => e.id == ad.id) ??
                    -1;
            final item = index >= 0
                ? states.controller?.itemList?.elementAt(index)
                : null;
            if (item != null) {
              states.controller?.itemList?.removeAt(index);
              states.controller?.itemList
                  ?.insert(index, item..status = UserAdStatus.WAIT);
            }
          } else {
            states.controller?.itemList?.remove(ad);
          }
          states.controller?.notifyListeners();

          stateMessageManager
              .showSuccessSnackBar(Strings.userAdsStatusSuccessfullyChanged);
        })
        .onError((error) {
          logger.w(error.toString());
          stateMessageManager
              .showErrorSnackBar(Strings.userAdsStatusChangingFailed);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> deleteAd(UserAd ad) async {
    _userAdRepository
        .deleteAd(ad.id)
        .initFuture()
        .onSuccess((data) {
          states.controller?.itemList?.remove(ad);
          states.controller?.notifyListeners();

          stateMessageManager
              .showSuccessSnackBar(Strings.userAdsStatusSuccessfullyChanged);
        })
        .onError((error) {
          logger.w(error.toString());

          stateMessageManager
              .showErrorSnackBar(Strings.userAdsStatusChangingFailed);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
