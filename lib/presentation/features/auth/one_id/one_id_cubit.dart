import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/data/repositories/favorite_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/extension_message_exts.dart';

part 'one_id_cubit.freezed.dart';
part 'one_id_state.dart';

@Injectable()
class OneIdCubit extends BaseCubit<OneIdState, OneIdEvent> {
  OneIdCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(const OneIdState());

  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  void loadPage() {
    if (!states.isPageLoadingFinished) {
      emitEvent(OneIdEvent(OneIdEventType.onStartPageLoading));
    }
  }

  void onPageStarted() {
    updateState((state) => state.copyWith(pageState: LoadingState.loading));
  }

  void onProcess() {
    // updateState((state) => state.copyWith(pageState: LoadingState.loading));
  }

  void onPageFinished() {
    updateState((state) => state.copyWith(pageState: LoadingState.success));
  }

  void onPageFailed() {
    updateState((state) => state.copyWith(pageState: LoadingState.error));
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
      stateMessageManager.showErrorSnackBar(e.localizedMessage);
    } finally {}
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
    } finally {
      emitEvent(OneIdEvent(OneIdEventType.onSuccessLogin));
    }
  }
}
