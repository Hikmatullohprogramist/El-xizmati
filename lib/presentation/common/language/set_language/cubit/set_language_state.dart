part of 'set_language_cubit.dart';

@freezed
class SetLanguageBuildable with _$SetLanguageBuildable {
  const factory SetLanguageBuildable() = _SetLanguageBuildable;
}

@freezed
class SetLanguageListenable with _$SetLanguageListenable {
  const factory SetLanguageListenable(SetLanguageEffect effect,
      {String? message}) = _SetLanguageListenable;
}

enum SetLanguageEffect { navigationAuthStart }
