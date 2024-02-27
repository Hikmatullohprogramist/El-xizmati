import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/repositories/user_ad_repository.dart';
import '../../../../../../../../../data/responses/user_ad/user_ad_response.dart';
import '../../../../../../../../../domain/models/ad/user_ad_status.dart';

part 'user_ad_list_cubit.freezed.dart';

part 'user_ad_list_state.dart';

@Injectable()
class UserAdListCubit
    extends BaseCubit<UserAdListBuildable, UserAdListListenable> {
  UserAdListCubit(this.userAdRepository) : super(const UserAdListBuildable());

  final UserAdRepository userAdRepository;

  void setInitialParams(UserAdStatus userAdStatus) {
    updateState((buildable) => buildable.copyWith(userAdStatus: userAdStatus));

    getController();
  }

  Future<void> getController() async {
    try {
      final controller =
          currentState.userAdsPagingController ?? getAdsController(status: 1);
      updateState(
            (buildable) =>
            buildable.copyWith(userAdsPagingController: controller),
      );
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(currentState.userAdsPagingController);
    }
  }

  PagingController<int, UserAdResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAdResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(currentState.userAdsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await userAdRepository.getUserAds(
          limit: 20,
          page: pageKey,
          userAdStatus: currentState.userAdStatus,
        );
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(currentState.userAdsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(currentState.userAdsPagingController);
      },
    );
    return adController;
  }
}
