import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/models/ad/user_ad.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.adCreationRepository) : super(PageState());

  final AdCreationRepository adCreationRepository;

  void setInitialParams(UserAd userAd) {
    updateState((state) => state.copyWith(userAd: userAd));
    getAdsDetailForEdit();
  }

  Future<void> getAdsDetailForEdit() async {
    // final user = adCreationRepository.getAdDetailsForEdit(
    //   adId: states.userAdResponse!.id,
    // );
  }
}
