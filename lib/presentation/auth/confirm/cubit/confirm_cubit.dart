import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'confirm_cubit.freezed.dart';

part 'confirm_state.dart';

class ConfirmCubit extends BaseCubit<ConfirmBuildable, ConfirmListenable> {
  ConfirmCubit() : super(ConfirmBuildable());
}