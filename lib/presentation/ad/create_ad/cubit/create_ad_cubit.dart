import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'create_ad_cubit.freezed.dart';

part 'create_ad_state.dart';

@injectable
class CreateAdCubit extends BaseCubit<CreateAdBuildable, CreateAdListenable> {
  CreateAdCubit() : super(const CreateAdBuildable());
}
