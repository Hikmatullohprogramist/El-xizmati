part of 'change_language_cubit.dart';

@freezed
class ChangeLanguageBuildable with _$ChangeLanguageBuildable {
  const factory ChangeLanguageBuildable({Language? language}) =
      _ChangeLanguageBuildable;
}

@freezed
class ChangeLanguageListenable with _$ChangeLanguageListenable {
  const factory ChangeLanguageListenable(ChangeLanguageEffect effect) =
      _ChangeLanguageListenable;
}

enum ChangeLanguageEffect { backTo }
