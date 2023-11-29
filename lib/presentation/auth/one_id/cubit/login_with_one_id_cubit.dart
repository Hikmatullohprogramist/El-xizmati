import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/repository/auth_repository.dart';

part 'login_with_one_id_cubit.freezed.dart';
part 'login_with_one_id_state.dart';

@Injectable()
class LoginWithOneIdCubit
    extends BaseCubit<LoginWithOneIdBuildable, LoginWithOneIdListenable> {
  LoginWithOneIdCubit(this._repository)
      : super(const LoginWithOneIdBuildable());

  final AuthRepository _repository;

  Future<void> loginWithOneId(String url) async {
    try {
      final uri = Uri.parse(url);
      await _repository.loginWithOneId(uri.queryParameters['code'] ?? "");
      invoke(LoginWithOneIdListenable(LoginWithOneIdEffect.navigationHome));
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }
}
