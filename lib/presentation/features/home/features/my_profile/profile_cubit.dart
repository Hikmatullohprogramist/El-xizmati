import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/repositories/auth_repository.dart';
import '../../../../support/cubit/base_cubit.dart';

part 'profile_cubit.freezed.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState, ProfileEvent>{
  final AuthRepository _authRepository;
  ProfileCubit(this._authRepository) : super(ProfileState()) {}
}
