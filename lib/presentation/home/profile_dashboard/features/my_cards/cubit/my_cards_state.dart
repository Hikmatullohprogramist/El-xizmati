part of 'my_cards_cubit.dart';

@freezed
class MyCardsBuildable with _$MyCardsBuildable {
  const factory MyCardsBuildable() = _MyCardsBuildable;
}

@freezed
class MyCardsListenable with _$MyCardsListenable {
  const factory MyCardsListenable(MyCardsEffect effect, {String? message}) =
  _MyCardsListenable;
}

enum MyCardsEffect { success }