part of 'create_service_request_cubit.dart';

@freezed
class CreateServiceOrderBuildable with _$CreateServiceOrderBuildable {
  const factory CreateServiceOrderBuildable() = _CreateServiceOrderBuildable;
}

@freezed
class CreateServiceOrderListenable with _$CreateServiceOrderListenable {
  const factory CreateServiceOrderListenable({
    CreateServiceOrderEffect? serviceOrderCreate1Effect,
  }) = _CreateServiceOrderListenable;
}

enum CreateServiceOrderEffect { success }
