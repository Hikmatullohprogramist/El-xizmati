import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'set_password_cubit.freezed.dart';

part 'set_password_state.dart';

@injectable
class SetPasswordCubit
    extends BaseCubit<SetPasswordBuildable, SetPasswordListenable> {
  SetPasswordCubit() : super(SetPasswordBuildable());
}
