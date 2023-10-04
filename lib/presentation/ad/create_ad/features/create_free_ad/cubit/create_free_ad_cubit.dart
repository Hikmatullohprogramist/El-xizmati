import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'create_free_ad_cubit.freezed.dart';

part 'create_free_ad_state.dart';

@Injectable()
class CreateFreeAdCubit
    extends BaseCubit<CreateFreeAdBuildable, CreateFreeAdListenable> {
  CreateFreeAdCubit() : super(const CreateFreeAdBuildable());
}
