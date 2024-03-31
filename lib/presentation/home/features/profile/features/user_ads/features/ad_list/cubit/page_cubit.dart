import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../data/repositories/user_ad_repository.dart';
import '../../../../../../../../../data/responses/user_ad/user_ad_response.dart';
import '../../../../../../../../../domain/models/ad/ad.dart';
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
      final controller = states.pagingController ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(pagingController: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
    }
  }

  PagingController<int, UserAdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAdResponse>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );

    adController.addPageRequestListener(
      (pageKey) async {
        try {
          final adsList = await userAdRepository.getUserAds(
            limit: 20,
            page: pageKey,
            userAdStatus: states.userAdStatus,
          );
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

  Future<void> removeAd(Ad ad) async {
    // try {
    //   final backendId = await userAdRepository.remove(ad);
    //   final index = states.controller?.itemList?.indexOf(ad) ?? 0;
    //   final item = states.controller?.itemList?.elementAt(index);
    //   if (item != null) {
    //     states.controller?.itemList?.insert(
    //         index,
    //         item
    //           ..favorite = true
    //           ..backendId = backendId);
    //     states.controller?.itemList?.removeAt(index);
    //     states.controller?.notifyListeners();
    //   }
    // } catch (error) {
    //   display.error("xatolik yuz  berdi");
    //   log.w(error.toString());
    // }
  }

  Future<void> deactivateAd(Ad ad) async {

  }

  Future<void> activateAd(Ad ad) async {

  }
}
