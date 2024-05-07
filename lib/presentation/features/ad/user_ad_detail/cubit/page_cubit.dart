import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/user_ad_detail_response.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.adCreationRepository) : super(PageState());

  final AdCreationRepository adCreationRepository;

  void setInitialParams(UserAd userAd) {
    updateState((state) => state.copyWith(userAd: userAd));
    getUserAdDetail();
  }

  List<String> getAdImages() {
    List<String> images = [];
    if (states.userAd?.mainPhoto != null) {
      images.add(states.userAd!.mainPhoto!);
    }
    return images;
  }

  Future<void> getUserAdDetail() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final userAdDetail = await adCreationRepository.getUserAdDetail(
        adId: states.userAd!.id,
      );

      updateState((state) => state.copyWith(
            loadState: LoadingState.success,
            userAdDetail: userAdDetail,
          ));
    } catch (e) {
      updateState((state) => state.copyWith(loadState: LoadingState.error));
      logger.w("get-user-ad-detail error = $e");
    }
  }
}
