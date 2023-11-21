part of 'add_card_cubit.dart';

@freezed
class AddCardBuildable with _$AddCardBuildable {
  const factory AddCardBuildable(
      {@Default(<String>[]) List<String> images,
      @Default(1) int selectedCard,
      String? cardName,
      String? cardNumber,
      String? cardExpired,
      @Default(false) bool isMain,
      @Default(false) bool isLoading}) = _AddCardBuildable;
}

@freezed
class AddCardListenable with _$AddCardListenable {
  const factory AddCardListenable() = _AddCardListenable;
}