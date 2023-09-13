import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'profile_edit_cubit.freezed.dart';

part 'profile_edit_state.dart';

@injectable
class ProfileEditCubit
    extends BaseCubit<ProfileEditBuildable, ProfileEditListenable> {
  ProfileEditCubit() : super(ProfileEditBuildable());
}
