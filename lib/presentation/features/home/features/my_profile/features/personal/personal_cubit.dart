import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:injectable/injectable.dart';
part 'personal_cubit.freezed.dart';
part 'personal_state.dart';
@injectable
class PersonalCubit extends BaseCubit<PersonalState, PersonalEvent>{
  PersonalCubit():super(PersonalState()){
      getUser();
  }
  Future<void> getUser() async{

  }
}