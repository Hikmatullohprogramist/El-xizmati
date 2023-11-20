part of 'user_cards_cubit.dart';

@freezed
class UserCardsBuildable with _$UserCardsBuildable {
  const factory UserCardsBuildable() = _UserCardsBuildable;
}

@freezed
class UserCardsListenable with _$UserCardsListenable {
  const factory UserCardsListenable(UserCardsEffect effect, {String? message}) =
  _UserCardsListenable;
}

enum UserCardsEffect { success }