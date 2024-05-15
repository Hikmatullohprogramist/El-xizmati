import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';

part 'auth_with_one_id_cubit.freezed.dart';
part 'auth_with_one_id_state.dart';

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
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {}
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
    } finally {
      emitEvent(PageEvent(PageEventType.onSuccessLogin));
    }
  }
}
