import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'identified_cubit.freezed.dart';

part 'identified_state.dart';

class IdentifiedCubit
    extends BaseCubit<IdentifiedBuildable, IdentifiedListenable> {
  IdentifiedCubit() : super(const IdentifiedBuildable());
}
