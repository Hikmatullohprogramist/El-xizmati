import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'create_ad_cubit.freezed.dart';

part 'create_ad_state.dart';

@injectable
class CreateAdCubit extends BaseCubit<CreateAdBuildable, CreateAdListenable> {
  CreateAdCubit() : super(const CreateAdBuildable());
}
