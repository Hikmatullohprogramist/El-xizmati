import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'ad_creation_result_cubit.freezed.dart';
part 'ad_creation_result_state.dart';

@Injectable()
class AdCreationResultCubit
    extends BaseCubit<AdCreationResultState, AdCreationResultEvent> {
  AdCreationResultCubit() : super(AdCreationResultState());

  void setInitialParams(int adId, AdTransactionType type) {
    logger.w("result page - adId = $adId, adTransactionType = $type");
    updateState((state) => state.copyWith(adId: adId, adTransactionType: type));
  }
}
