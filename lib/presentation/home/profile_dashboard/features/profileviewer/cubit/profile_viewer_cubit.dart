import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'profile_viewer_cubit.freezed.dart';

part 'profile_viewer_state.dart';

@injectable
class ProfileViewerCubit
    extends BaseCubit<ProfileViewerBuildable, ProfileViewerListenable> {
  ProfileViewerCubit() : super(ProfileViewerBuildable());
}
