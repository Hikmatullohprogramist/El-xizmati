import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'create_service_request_cubit.freezed.dart';

part 'create_service_request_state.dart';

@Injectable()
class ServiceOrderCreateCubit extends BaseCubit<CreateServiceOrderBuildable, CreateServiceOrderListenable> {
  ServiceOrderCreateCubit() : super(const CreateServiceOrderBuildable());
}
