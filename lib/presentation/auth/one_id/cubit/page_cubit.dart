import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._repository,
    this._favoriteRepository,
  ) : super(const PageState());

  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;

  Future<void> loginWithOneId(String url) async {
    try {
      final uri = Uri.parse(url);
      await _repository.loginWithOneId(uri.queryParameters['code'] ?? "");
      emitEvent(PageEvent(PageEventType.navigationHome));
      await sendAllFavoriteAds();
    } on DioException catch (e) {
      display.error(e.toString());
    } finally {}
  }

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.navigationHome));
    }
  }
}
