import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../../../../../../common/enum/enums.dart';

part 'ad_list_actions_cubit.freezed.dart';

part 'ad_list_actions_state.dart';

@Injectable()
class AdListActionsCubit
    extends BaseCubit<AdListActionsBuildable, AdListActionsListenable> {
  AdListActionsCubit(this._repository) : super(AdListActionsBuildable()) {
    // getItems();
  }

  final AdCreationRepository _repository;

  void setInitialParams(
    UserAdResponse? userAdResponse,
    UserAdStatus? userAdStatus,
  ) {
    build(
      (buildable) => buildable.copyWith(
        userAdResponse: userAdResponse,
        userAdStatus: userAdStatus,
        isEditEnabled: true,
        isAdvertiseEnabled:
            [UserAdStatus.active, UserAdStatus.all].contains(userAdStatus),
        isActivateEnabled: [
          UserAdStatus.inactive,
          UserAdStatus.canceled,
          UserAdStatus.rejected
        ].contains(userAdStatus),
        isDeactivateEnabled:
            [UserAdStatus.active, UserAdStatus.all].contains(userAdStatus),
        isDeleteEnabled: userAdStatus == UserAdStatus.inactive,
      ),
    );
  }

  Future<void> getItems() async {
    try {
      final items = await _repository.getUnitsForCreationAd();
      log.i(items.toString());
      // build((buildable) => buildable.copyWith(
      //       items: items,
      //       itemsLoadState: LoadingState.success,
      //     ));
    } on DioException catch (exception) {
      log.e(exception.toString());
      // build((buildable) => buildable.copyWith(
      //   itemsLoadState: LoadingState.error,
      // ));
    }
  }
}
