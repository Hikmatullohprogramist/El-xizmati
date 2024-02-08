import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'create_ad_start_cubit.freezed.dart';

part 'create_ad_start_state.dart';

@Injectable()
class CreateAdStartCubit extends BaseCubit<CreateAdStartBuildable, CreateAdStartListenable> {
  CreateAdStartCubit() : super(const CreateAdStartBuildable());
}
