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
    final ad = await adCreationRepository.getServiceAdForEdit(
      adId: states.userAd!.id,
    );

    // updateState((state) => state.copyWith(
    //
    // ))
  }
}
