import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'auth_start_cubit.freezed.dart';

part 'auth_start_state.dart';

@injectable
class AuthStartCubit
    extends BaseCubit<AuthStartBuildable, AuthStartListenable> {
  AuthStartCubit() : super(AuthStartBuildable());
}
