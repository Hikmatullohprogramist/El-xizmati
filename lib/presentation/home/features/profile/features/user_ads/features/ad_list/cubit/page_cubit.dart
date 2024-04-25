import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../../../../../../data/repositories/user_ad_repository.dart';
import '../../../../../../../../../domain/models/ad/user_ad.dart';
import '../../../../../../../../../domain/models/ad/user_ad_status.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.userAdRepository) : super(const PageState());

  final UserAdRepository userAdRepository;

  void setInitialParams(UserAdStatus userAdStatus) {
    updateState((state) => state.copyWith(userAdStatus: userAdStatus));

    getController();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  PagingController<int, UserAd> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAd>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );

    adController.addPageRequestListener(
      (pageKey) async {
        try {
          final response = await userAdRepository.getUserAds(
            limit: 20,
            page: pageKey,
            userAdStatus: states.userAdStatus,
          );
          final adsList = response.map((e) => e.toMap()).toList();
          if (adsList.length < 20) {
            adController.appendLastPage(adsList);
            return;
          }
          adController.appendPage(adsList, pageKey + 1);
        } catch (error) {
          adController.error = error;
        }
      },
    );
    return adController;
  }

  Future<void> deactivateAd(UserAd ad) async {
    try {
      final response = await userAdRepository.deactivateAd(ad.id);
      if (states.userAdStatus == UserAdStatus.ALL) {
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.removeAt(index);
          states.controller?.itemList
              ?.insert(index, item..status = UserAdStatus.INACTIVE);
        }
      } else {
        states.controller?.itemList?.remove(ad);
      }
      states.controller?.notifyListeners();
    } catch (error) {
      log.w(error.toString());
    }
  }

  Future<void> activateAd(UserAd ad) async {
    try {
      final response = await userAdRepository.activateAd(ad.id);
      if (states.userAdStatus == UserAdStatus.ALL) {
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.removeAt(index);
          states.controller?.itemList
              ?.insert(index, item..status = UserAdStatus.WAIT);
        }
      } else {
        states.controller?.itemList?.remove(ad);
      }
      states.controller?.notifyListeners();
    } catch (error) {
      log.w(error.toString());
    }
  }

  Future<void> deleteAd(UserAd ad) async {
    try {
      final response = await userAdRepository.deleteAd(ad.id);
      states.controller?.itemList?.remove(ad);
      states.controller?.notifyListeners();
    } catch (error) {
      log.w(error.toString());
    }
  }
}
