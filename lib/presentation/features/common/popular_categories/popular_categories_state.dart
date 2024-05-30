part of 'popular_categories_cubit.dart';

@freezed
class PopularCategoriesState with _$PopularCategoriesState {
  const factory PopularCategoriesState({
    PagingController<int, PopularCategory>? controller,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PopularCategoriesState;
}

@freezed
class PopularCategoriesEvent with _$PopularCategoriesEvent {
  const factory PopularCategoriesEvent() = _PopularCategoriesEvent;
}
