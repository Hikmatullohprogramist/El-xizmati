import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import '../../../../../domain/repositories/state_repository.dart';

part 'profile_dashboard_cubit.freezed.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileBuildable, ProfileListenable> {
  ProfileCubit(
    this.authRepository,
    this.stateRepository,
  ) : super(ProfileBuildable()) {
    isLogin();
    getLanguage();
  }

  final AuthRepository authRepository;
  final StateRepository stateRepository;

  Future<void> getLanguage() async {
    try {
      final languageName = await stateRepository.getLanguageName();
      late Language language;
      if (languageName == 'uz') {
        language = Language.uzbekLatin;
      } else {
        if (languageName == 'ru') {
          language = Language.russian;
        } else {
          language = Language.uzbekCyrill;
        }
      }
      build((buildable) => buildable.copyWith(language: language));
    } catch (e) {}
  }

  Future<void> selectLanguage(Language language, String languageName) async {
    build((buildable) => buildable.copyWith(language: language));
    await stateRepository.setLanguage(languageName);
  }

  Future<void> logOut() async {
    try {
      log.w("logOut call");
      await authRepository.logOut();
      build((buildable) => buildable.copyWith(isLogin: false));
      invoke(ProfileListenable(ProfileEffect.onLogOut));
    } on DioException {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> isLogin() async {
    final isLogin = await stateRepository.isLogin() ?? false;
    build((buildable) => buildable.copyWith(isLogin: isLogin));
  }
}

enum Language { uzbekLatin, russian, uzbekCyrill }
