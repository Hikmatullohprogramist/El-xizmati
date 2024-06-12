import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'set_language_cubit.freezed.dart';
part 'set_language_state.dart';

@injectable
class SetLanguageCubit extends BaseCubit<SetLanguageState, SetLanguageEvent> {
  SetLanguageCubit(this._stateRepository) : super(const SetLanguageState()) {
    setLanguage(Language.uzbekLatin);
  }

  final StateRepository _stateRepository;

  void getLanguage() => _stateRepository.getLanguage();

  bool get isRussianSelected =>
      _stateRepository.getLanguage() == Language.russian;

  bool get isUzbekLatinSelected =>
      _stateRepository.getLanguage() == Language.uzbekLatin;

  bool get isUzbekCyrillSelected =>
      _stateRepository.getLanguage() == Language.uzbekCyrill;

  Future<void> setLanguage(Language language) async {
    await _stateRepository.setLanguage(language);
    // emitEvent(PageEvent(PageEventType.navigationAuthStart));
  }
}
