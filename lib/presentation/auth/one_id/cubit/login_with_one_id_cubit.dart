import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'login_with_one_id_cubit.freezed.dart';
part 'login_with_one_id_state.dart';

@Injectable()
class LoginWithOneIdCubit
    extends BaseCubit<LoginWithOneIdBuildable, LoginWithOneIdListenable> {
  LoginWithOneIdCubit(this._repository, this._favoriteRepository)
      : super(const LoginWithOneIdBuildable());

  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;

  Future<void> loginWithOneId(String url) async {
    try {
      final uri = Uri.parse(url);
      await _repository.loginWithOneId(uri.queryParameters['code'] ?? "");
      invoke(LoginWithOneIdListenable(LoginWithOneIdEffect.navigationHome));
      await sendAllFavoriteAds();
    } on DioException catch (e) {
      display.error(e.toString());
    } finally {}
  }

  void hideLoading() {
    build((buildable) => buildable.copyWith(isLoading: false));
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      invoke(LoginWithOneIdListenable(LoginWithOneIdEffect.navigationHome));
    }
  }
}
