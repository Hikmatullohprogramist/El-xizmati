import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'promotion_state.dart';
part 'promotion_cubit.freezed.dart';

@injectable
class PromotionCubit extends BaseCubit<PromotionBuildable, PromotionListenable> {
  PromotionCubit() : super(const PromotionBuildable());
}
