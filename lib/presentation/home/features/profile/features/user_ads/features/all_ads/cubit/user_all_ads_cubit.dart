import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/repositories/user_ad_repository.dart';
import '../../../../../../../../../data/responses/user_ad/user_ad_response.dart';
import '../../../../../../../../../domain/models/ad/user_ad_status.dart';

part 'user_all_ads_cubit.freezed.dart';
part 'user_all_ads_state.dart';

@Injectable()
class UserAllAdsCubit
    extends BaseCubit<UserAllAdsBuildable, UserAllAdsListenable> {
  UserAllAdsCubit(this.userAdRepository) : super(const UserAllAdsBuildable()) {
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
            limit: 20, page: pageKey, userAdStatus: UserAdStatus.all);
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
