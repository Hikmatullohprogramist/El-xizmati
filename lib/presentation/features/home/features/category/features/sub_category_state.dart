part of 'sub_category_cubit.dart';

@freezed
class SubCategoryState with _$SubCategoryState {
  const factory SubCategoryState({
    @Default(<Results>[]) List<Results> items,
    @Default(0) int parentId,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _SubCategoryState;
}

@freezed
class SubCategoryEvent with _$SubCategoryEvent {
  const factory SubCategoryEvent() = _SubCategoryEvent;
}
