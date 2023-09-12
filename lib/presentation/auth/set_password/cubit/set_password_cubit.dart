import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_password_state.dart';
part 'set_password_cubit.freezed.dart';

class SetPasswordCubit extends Cubit<SetPasswordState> {
  SetPasswordCubit() : super(const SetPasswordState.initial());
}
