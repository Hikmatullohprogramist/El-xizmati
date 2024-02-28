import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/repositories/user_ad_repository.dart';
import '../../../../../../../../../data/responses/user_ad/user_ad_response.dart';
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
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, UserAdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAdResponse>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await userAdRepository.getUserAds(
          limit: 20,
          page: pageKey,
          userAdStatus: states.userAdStatus,
        );
        if (adsList.length <= 19) {
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
}
