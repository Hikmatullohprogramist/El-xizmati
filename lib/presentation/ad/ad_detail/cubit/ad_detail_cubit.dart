import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repo/ad_repository.dart';

part 'ad_detail_cubit.freezed.dart';
part 'ad_detail_state.dart';

@injectable
class AdDetailCubit extends BaseCubit<AdDetailBuildable, AdDetailListenable> {
  AdDetailCubit(this._adRepository) : super(AdDetailBuildable());

  final AdRepository _adRepository;

  void setAdId(int adId) {
    build((buildable) => buildable.copyWith(adId: adId));
    // getDetailResponse();
  }

// Future<void> getDetailResponse() async {
//   try {
//     var response = await _adRepository.getAdDetail(buildable.adId!);
//     build((buildable) => buildable.copyWith(adDetailResponse: response));
//   } catch (e) {
//     display.error(e.toString());
//   }
// }
}
