import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/user_ad_detail_response.dart';
import 'package:onlinebozor/data/repositories/user_ad_repository.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_ad_detail_cubit.freezed.dart';
part 'user_ad_detail_state.dart';

@Injectable()
class UserAdDetailCubit
    extends BaseCubit<UserAdDetailState, UserAdDetailEvent> {
  UserAdDetailCubit(this._userAdRepository) : super(UserAdDetailState());

  final UserAdRepository _userAdRepository;

  void setInitialParams(UserAd userAd) {
    updateState((state) => state.copyWith(userAd: userAd));
    getUserAdDetail();
  }

  Future<void> getUserAdDetail() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final ad = await _userAdRepository.getUserAdDetail(id: states.userAd!.id);

      updateState((state) => state.copyWith(
            loadState: LoadingState.success,
            userAdDetail: ad,
            adPhotos: ad.photos?.map((e) => e.image).toSet().toList() ?? [],
          ));
    } catch (e) {
      updateState((state) => state.copyWith(loadState: LoadingState.error));
      logger.w("get-user-ad-detail error = $e");
    }
  }
}
