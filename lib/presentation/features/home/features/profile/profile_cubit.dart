import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/language_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/theme_mode_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/theme/app_theme_mode.dart';
import 'package:onlinebozor/presentation/stream_controllers/app_theme_mode_stream_controller.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState, ProfileEvent> {
  final AppThemeModeStreamController _appThemeModeStreamController;
  final AuthRepository _authRepository;
  final LanguageRepository _languageRepository;
  final StateRepository _stateRepository;
  final ThemeModeRepository _themeModeRepository;
  final UserRepository _userRepository;

  ProfileCubit(
    this._appThemeModeStreamController,
    this._authRepository,
    this._languageRepository,
    this._stateRepository,
    this._themeModeRepository,
    this._userRepository,
  ) : super(ProfileState()) {
    checkAndUpdateUserProfile();
    isUserLoggedIn();

    getLanguage();
    getThemeMode();
  }

  void checkAndUpdateUserProfile() {
    _userRepository
        .getUser()
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          logger.e("getUser user = $data");
        })
        .onError((error) {
          logger.e("getUser error = ${error.toString()}");
        })
        .onFinished(() {})
        .executeFuture();
  }

  void getLanguage() async {
    final language = _languageRepository.getLanguage();
    updateState((state) => state.copyWith(language: language));
  }

  void getThemeMode() async {
    final mode = _themeModeRepository.getAppThemeMode();
    updateState((state) => state.copyWith(appThemeMode: mode));
  }

  void setSelectedLanguage(Language language, String languageName) async {
    updateState((state) => state.copyWith(language: language));
    await _languageRepository.setLanguage(language);
  }

  void setSelectedThemeMode(AppThemeMode mode) async {
    await _themeModeRepository.setAppThemeMode(mode);
    updateState((state) => state.copyWith(appThemeMode: mode));
    _appThemeModeStreamController.add(mode);
  }

  Future<void> logOut() async {
    try {
      logger.w("logOut call");
      await _authRepository.logOut();
      updateState((state) => state.copyWith(isAuthorized: false));
      emitEvent(ProfileEvent(ProfileEventType.onLogOut));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
    }
  }

  Future<void> isUserLoggedIn() async {
    final isAuthorized = _stateRepository.isAuthorized();
    updateState((state) => state.copyWith(isAuthorized: isAuthorized));
  }
}
