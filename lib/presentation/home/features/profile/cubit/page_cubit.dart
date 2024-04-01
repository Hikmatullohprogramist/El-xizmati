import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/auth_repository.dart';
import '../../../../../data/repositories/state_repository.dart';
import '../../../../../domain/models/language/language.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this.authRepository,
    this.stateRepository,
  ) : super(PageState()) {
    isLogin();
    getLanguage();
  }

  final AuthRepository authRepository;
  final StateRepository stateRepository;

  Future<void> getLanguage() async {
    try {
      final language = await stateRepository.getLanguage();
      updateState((state) => state.copyWith(language: language));
    } catch (e) {
      log.w(e);
    }
  }

  Future<void> selectLanguage(Language language, String languageName) async {
    updateState((state) => state.copyWith(language: language));
    await stateRepository.setLanguage(languageName);
  }

  Future<void> logOut() async {
    try {
      log.w("logOut call");
      await authRepository.logOut();
      updateState((state) => state.copyWith(isLogin: false));
      emitEvent(PageEvent(PageEventType.onLogOut));
    } on DioException {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> isLogin() async {
    final isLogin = await stateRepository.isLogin() ?? false;
    updateState((state) => state.copyWith(isLogin: isLogin));
  }
}
