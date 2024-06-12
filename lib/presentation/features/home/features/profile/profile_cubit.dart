import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState, ProfileEvent> {
  ProfileCubit(
    this._authRepository,
    this._stateRepository,
  ) : super(ProfileState()) {
    isUserLoggedIn();
    getLanguage();
  }

  final AuthRepository _authRepository;
  final StateRepository _stateRepository;

  Future<void> getLanguage() async {
    try {
      final language = _stateRepository.getLanguage();
      updateState((state) => state.copyWith(language: language));
    } catch (e) {
      logger.w(e);
    }
  }

  Future<void> selectLanguage(Language language, String languageName) async {
    updateState((state) => state.copyWith(language: language));
    await _stateRepository.setLanguage(language);
  }

  Future<void> logOut() async {
    try {
      logger.w("logOut call");
      await _authRepository.logOut();
      updateState((state) => state.copyWith(isLogin: false));
      emitEvent(ProfileEvent(ProfileEventType.onLogOut));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
    }
  }

  Future<void> isUserLoggedIn() async {
    final isUserLoggedIn = _stateRepository.isAuthorized();
    updateState((state) => state.copyWith(isLogin: isUserLoggedIn));
  }
}
