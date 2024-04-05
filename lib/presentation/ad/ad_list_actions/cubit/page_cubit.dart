import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../../../../../../common/enum/enums.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

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
