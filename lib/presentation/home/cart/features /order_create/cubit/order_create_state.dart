part of 'order_create_cubit.dart';

@freezed
class OrderCreateBuildable with _$OrderCreateBuildable {
  const factory OrderCreateBuildable(
      {int? adId,
      AdDetail? adDetail,
      @Default(false) bool favorite,
      @Default(-1) int paymentId,
      @Default(<int>[]) List<int> paymentType,
      @Default(1) int count}) = _OrderCreateBuildable;
}

@freezed
class OrderCreateListenable with _$OrderCreateListenable {
  const factory OrderCreateListenable(OrderCreateEffect effect,
      {String? message}) = _OrderCreateListenable;
}

enum OrderCreateEffect { delete, back, navigationAuthStart }