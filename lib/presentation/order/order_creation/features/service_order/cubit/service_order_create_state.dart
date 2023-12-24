part of 'service_order_create_cubit.dart';

@freezed
class ServiceOrderCreateBuildable with _$ServiceOrderCreateBuildable {
  const factory ServiceOrderCreateBuildable() = _ServiceOrderCreateBuildable;
}

@freezed
class ServiceOrderCreateListenable with _$ServiceOrderCreateListenable {
  const factory ServiceOrderCreateListenable({ServiceOrderCreateEffect? serviceOrderCreate1Effect}) = _ServiceOrderCreateListenable;
}

enum ServiceOrderCreateEffect{success}
