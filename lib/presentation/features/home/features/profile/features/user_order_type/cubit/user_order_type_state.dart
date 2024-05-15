part of 'user_order_type_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState() = _UserOrderStartBuildable;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
