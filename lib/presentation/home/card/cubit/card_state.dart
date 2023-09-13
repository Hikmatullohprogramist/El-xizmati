part of 'card_cubit.dart';

@freezed
class CardBuildable with _$CardBuildable {
  const factory CardBuildable() = _CardBuildable;
}

@freezed
class CardListenable with _$CardListenable {
  const factory CardListenable(CardEffect effect, {String? message}) =
  _CardListenable;
}

enum CardEffect { success }