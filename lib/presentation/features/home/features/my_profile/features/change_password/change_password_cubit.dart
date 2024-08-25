import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';
class ChangePasswordCubit extends BaseCubit<ChangePasswordState, ChangePasswordEvent>{
  ChangePasswordCubit():super(ChangePasswordState()){
    changePassword();
  }
  Future<void> changePassword() async{

  }
}