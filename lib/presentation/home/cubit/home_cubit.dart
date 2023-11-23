import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/state_repository.dart';

part 'home_cubit.freezed.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeBuildable, HomeListenable> {
  HomeCubit(this._stateRepository) : super(HomeBuildable());

  final StateRepository _stateRepository;

  Future<void> isLogin() async {
    try {
      final isLogin = await _stateRepository.isLogin();
      build((buildable) => buildable.copyWith(isLogin: isLogin ?? false));
    }on DioException  catch (e) {
      display.error(e.toString());
    }
  }
}
