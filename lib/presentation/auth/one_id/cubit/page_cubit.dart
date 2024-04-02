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
    this._authRepository,
    this._favoriteRepository,
  ) : super(const PageState());

  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  Future<void> loginWithOneId(String url) async {
    try {
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'] ?? "";
      if (code.isNotEmpty) {
        await _authRepository.loginWithOneId(code);
        await sendAllFavoriteAds();
      } else {}
    } catch (e) {
      display.error(e.toString());
    } finally {}
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
    } finally {
      emitEvent(PageEvent(PageEventType.onSuccessLogin));
    }
  }
}
