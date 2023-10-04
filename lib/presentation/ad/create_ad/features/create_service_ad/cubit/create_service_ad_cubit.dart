import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'create_service_ad_cubit.freezed.dart';

part 'create_service_ad_state.dart';

@Injectable()
class CreateServiceAdCubit
    extends BaseCubit<CreateServiceAdBuildable, CreateServiceAdListenable> {
  CreateServiceAdCubit() : super(CreateServiceAdBuildable());
}
