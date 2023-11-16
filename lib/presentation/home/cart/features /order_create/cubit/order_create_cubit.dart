import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

import '../../../../../../domain/model/ad_detail.dart';
import '../../../../../../domain/repository/ad_repository.dart';

part 'order_create_cubit.freezed.dart';

part 'order_create_state.dart';

@Injectable()
class OrderCreateCubit
    extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit(this._adRepository) : super(const OrderCreateBuildable());
  final AdRepository _adRepository;

  void setAdId(int adId) {
    build((buildable) => buildable.copyWith(adId: adId));
    getDetailResponse();
  }

  Future<void> getDetailResponse() async {
    try {
      var response = await _adRepository.getAdDetail(buildable.adId!);
      build((buildable) => buildable.copyWith(adDetail: response));
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }
}
