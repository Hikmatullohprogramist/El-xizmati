import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_verification_state.dart';
part 'auth_verification_cubit.freezed.dart';

class AuthVerificationCubit extends Cubit<AuthVerificationState> {
  AuthVerificationCubit() : super(const AuthVerificationState.initial());
}
