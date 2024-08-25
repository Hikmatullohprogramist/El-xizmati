import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/repositories/region_repository.dart';
import 'package:El_xizmati/domain/models/region/set_region_event.dart';
import 'package:El_xizmati/presentation/stream_controllers/selected_region_stream_controller.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'set_intro_region_cubit.freezed.dart';
part 'set_intro_region_state.dart';

@injectable
class SetIntroCubit
    extends BaseCubit<SetIntroState, SetIntroEvent> {
  final RegionRepository _regionRepository;
  final SelectedRegionStreamController _selectedRegionStreamController;

  SetIntroCubit(this._regionRepository, this._selectedRegionStreamController)
      : super(SetIntroState()) ;


  @override
  Future<void> close() async {
    super.close();
  }

 /* void _subscribeStreams() {
    _selectedRegionSubs?.cancel();
    _selectedRegionSubs = _selectedRegionStreamController.listen((event) {
      if(event == SetRegionResult.regionChanged){
        emitEvent(SetIntroEvent(SetIntroEventType.onSet));
      }
    });
  }

  Future<void> getRegionResult() async {
    _regionRepository.getSelectedRegionName();
  }

  void SetIntroSelection () async{
    await _regionRepository.setIntroRegionSelection();

  }*/

  Future<void> SetIntro() async {
   // SetIntroSelection();
  }

  Future<void> skipIntroRegion() async {
    emitEvent(SetIntroEvent(SetIntroEventType.onSkip));
  }
}
