import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

part 'verification_cubit.freezed.dart';

part 'verification_state.dart';

class VerificationCubit
    extends BaseCubit<VerificationBuildable, VerificationListenable> {
  VerificationCubit() : super(const VerificationBuildable());
}
