import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

 part 'auth_confirm_cubit.freezed.dart';

part 'auth_confirm_state.dart';

@injectable
class AuthConfirmCubit extends BaseCubit<AuthBuildable, AuthListenable> {
  AuthConfirmCubit() : super(AuthBuildable());
}
