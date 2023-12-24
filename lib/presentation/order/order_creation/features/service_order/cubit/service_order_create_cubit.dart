import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'service_order_create_cubit.freezed.dart';

part 'service_order_create_state.dart';

@Injectable()
class ServiceOrderCreateCubit extends BaseCubit<ServiceOrderCreateBuildable, ServiceOrderCreateListenable> {
  ServiceOrderCreateCubit() : super(const ServiceOrderCreateBuildable());
}
