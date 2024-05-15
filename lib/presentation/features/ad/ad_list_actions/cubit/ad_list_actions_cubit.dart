import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../../../../../../core/enum/enums.dart';

part 'ad_list_actions_cubit.freezed.dart';
part 'ad_list_actions_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(PageState());

  void setInitialParams(
    UserAdResponse? userAdResponse,
    UserAdStatus? userAdStatus,
  ) {
    updateState(
      (state) => state.copyWith(
        userAdResponse: userAdResponse,
        userAdStatus: userAdStatus,
        isEditEnabled: true,
        // isAdvertiseEnabled: [UserAdStatus.active, UserAdStatus.all,].contains(userAdStatus),
        isAdvertiseEnabled: false,
        isActivateEnabled: [
          UserAdStatus.INACTIVE,
          UserAdStatus.CANCELLED,
          UserAdStatus.REJECTED,
        ].contains(userAdStatus),
        isDeactivateEnabled: [
          UserAdStatus.ACTIVE,
          UserAdStatus.ALL,
        ].contains(userAdStatus),
        isDeleteEnabled: [
          UserAdStatus.INACTIVE,
          UserAdStatus.REJECTED,
          UserAdStatus.CANCELLED,
        ].contains(userAdStatus),
      ),
    );
  }
}
