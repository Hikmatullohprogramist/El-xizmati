part of 'create_service_request_cubit.dart';

@freezed
class CreateServiceOrderBuildable with _$ServiceOrderCreateBuildable {
  const factory CreateServiceOrderBuildable() = _ServiceOrderCreateBuildable;
}

@freezed
class CreateServiceOrderListenable with _$ServiceOrderCreateListenable {
  const factory CreateServiceOrderListenable({
    CreateServiceOrderEffect? serviceOrderCreate1Effect,
  }) = _ServiceOrderCreateListenable;
}

enum CreateServiceOrderEffect { success }
