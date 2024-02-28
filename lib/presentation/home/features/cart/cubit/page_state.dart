part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<Ad>[]) List<Ad> items,
    PagingController<int, Ad>? controller,
    @Default(false) bool checkBox,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
