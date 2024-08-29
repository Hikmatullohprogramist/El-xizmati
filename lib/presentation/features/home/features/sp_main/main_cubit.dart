import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'main_state.dart';
part 'main_cubit.freezed.dart';

@injectable
class MainCubit extends BaseCubit<MainState, MainEvent>{
  MainCubit():super(MainState());

}
