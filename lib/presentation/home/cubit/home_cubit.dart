import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/state_repository.dart';

import '../../../common/core/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeBuildable, HomeListenable> {
  HomeCubit(this._stateRepository) : super(HomeBuildable()) {
    init();
  }

  Future<void> init() async {
    Hive.box("favorites_storage")
        .listenable(keys: ["key_favorites_storage"]).addListener(() {
      int favoriteNumber = Hive.box("favorites_storage").length;
      build((buildable) => buildable.copyWith(favoriteAmount: favoriteNumber));
      display.success("favorite change $favoriteNumber");
    });

    Hive.box("cart_storage")
        .listenable(keys: ["key_cart_storage"]).addListener(() {
      int cartNumber = Hive.box("cart_storage").length;
      build((buildable) => buildable.copyWith(cartAmount: cartNumber));
      display.success("cart change $cartNumber");
    });
  }

  final StateRepository _stateRepository;

  Future<void> isLogin() async {
    try {
      final isLogin = await _stateRepository.isLogin();
      build((buildable) => buildable.copyWith(isLogin: isLogin ?? false));
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }
}
