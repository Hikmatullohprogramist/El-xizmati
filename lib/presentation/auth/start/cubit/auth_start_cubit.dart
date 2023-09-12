import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_start_state.dart';
part 'auth_start_cubit.freezed.dart';

class AuthStartCubit extends Cubit<AuthStartState> {
  AuthStartCubit() : super(const AuthStartState.initial());
}
