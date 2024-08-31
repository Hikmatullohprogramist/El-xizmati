import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'ad_create_state.dart';
part 'ad_create_cubit.freezed.dart';

@injectable
class AdCreateCubit extends BaseCubit<AdCreateState, AdCreateEvent>{
  AdCreateCubit():super(AdCreateState());
  void setScrolling(bool isScrolling){
    updateState((state)=> state.copyWith(isScrolling:isScrolling));
  }

}