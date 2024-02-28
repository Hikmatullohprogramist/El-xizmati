part of 'popular_categories_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    PagingController<int, PopularCategoryResponse>? controller,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
