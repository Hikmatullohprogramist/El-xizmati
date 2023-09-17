import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_state.dart';
part 'confirm_cubit.freezed.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  ConfirmCubit() : super(const ConfirmState.initial());
}
