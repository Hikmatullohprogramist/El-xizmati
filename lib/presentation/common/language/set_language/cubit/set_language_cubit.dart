import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import '../../../../../data/repositories/state_repository.dart';

part 'set_language_cubit.freezed.dart';

part 'set_language_state.dart';

@injectable
class SetLanguageCubit
    extends BaseCubit<SetLanguageBuildable, SetLanguageListenable> {
  SetLanguageCubit(this.stateRepository) : super(const SetLanguageBuildable());

  StateRepository stateRepository;

  Future<void> setLanguage(Language language) async {
    await stateRepository.languageSelection(true);
    await stateRepository.setLanguage(language.name);
    emitEvent(SetLanguageListenable(
      SetLanguageEffect.navigationAuthStart,
    ));
    updateState((buildable) => buildable);
  }
}

enum Language { uz, ru, kr }
