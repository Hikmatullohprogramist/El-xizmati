import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit_new.dart';
import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/responses/user_ad/user_ad_response.dart';
import '../../../../../../../../../domain/models/ad/user_ad_status.dart';
import '../../../../../../../../../domain/repositories/user_ad_repository.dart';

part 'user_pending_ads_cubit.freezed.dart';
part 'user_pending_ads_state.dart';

@Injectable()
class UserPendingAdsCubit
    extends BaseCubit<UserPendingAdsBuildable, UserPendingAdsListenable> {
  UserPendingAdsCubit(this.userAdRepository)
      : super(const UserPendingAdsBuildable()) {
    getController();
  }

  final UserAdRepository userAdRepository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.userAdsPagingController ?? getAdsController(status: 1);
      build((buildable) =>
          buildable.copyWith(userAdsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.userAdsPagingController);
    }
  }

  PagingController<int, UserAdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAdResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.userAdsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await userAdRepository.getUserAds(
            limit: 20, page: pageKey, userAdStatus: UserAdStatus.wait);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(buildable.userAdsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.userAdsPagingController);
      },
    );
    return adController;
  }
}
