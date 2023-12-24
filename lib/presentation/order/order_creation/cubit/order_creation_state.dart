part of 'order_creation_cubit.dart';

@freezed
class OrderCreationBuildable with _$OrderCreationBuildable {
  const factory OrderCreationBuildable() = _OrderCreationBuildable;
}

@freezed
class OrderCreationListenable with _$OrderCreationListenable {
  const factory OrderCreationListenable({OrderCreationEffect? orderCreateEffect}) = _OrderCreationListenable;
}

enum OrderCreationEffect{success}
