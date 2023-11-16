part of 'order_create_cubit.dart';

@freezed
class OrderCreateBuildable with _$OrderCreateBuildable {
  const factory OrderCreateBuildable({int? adId, AdDetail? adDetail}) = _OrderCreateBuildable;
}

@freezed
class OrderCreateListenable with _$OrderCreateListenable {
  const factory OrderCreateListenable() = _OrderCreateListenable;
}
