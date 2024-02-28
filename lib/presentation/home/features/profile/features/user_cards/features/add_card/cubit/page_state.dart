part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<String>[]) List<String> images,
    @Default(1) int selectedCard,
    String? cardName,
    String? cardNumber,
    String? cardExpired,
    @Default(false) bool isMain,
    @Default(false) bool isLoading,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
