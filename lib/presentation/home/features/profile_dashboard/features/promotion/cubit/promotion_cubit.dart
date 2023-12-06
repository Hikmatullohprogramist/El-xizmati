import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit_new.dart';

part 'promotion_cubit.freezed.dart';

part 'promotion_state.dart';

@injectable
class PromotionCubit
    extends BaseCubit<PromotionBuildable, PromotionListenable> {
  PromotionCubit() : super(const PromotionBuildable());
}
