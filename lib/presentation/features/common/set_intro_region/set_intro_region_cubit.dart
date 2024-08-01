import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/language_repository.dart';
import 'package:onlinebozor/data/repositories/region_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/region/set_region_event.dart';
import 'package:onlinebozor/presentation/stream_controllers/selected_region_stream_controller.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'set_intro_region_cubit.freezed.dart';
part 'set_intro_region_state.dart';

@injectable
class SetIntroRegionCubit
    extends BaseCubit<SetIntroRegionState, SetIntroRegionEvent> {
  final RegionRepository _regionRepository;
  final SelectedRegionStreamController _selectedRegionStreamController;

  SetIntroRegionCubit(this._regionRepository, this._selectedRegionStreamController)
      : super(SetIntroRegionState()) {
    setIntroRegionSelection();
    _subscribeStreams();
  }

  StreamSubscription? _selectedRegionSubs;

  @override
  Future<void> close() async {
    await _selectedRegionSubs?.cancel();

    super.close();
  }

  void _subscribeStreams() {
    _selectedRegionSubs?.cancel();
    _selectedRegionSubs = _selectedRegionStreamController.listen((event) {
      if(event == SetRegionResult.regionChanged){
        emitEvent(SetIntroRegionEvent(SetIntroRegionEventType.onSet));
      }
    });
  }

  Future<void> getRegionResult() async {
    _regionRepository.getSelectedRegionName();
  }

  void setIntroRegionSelection () async{
    await _regionRepository.setIntroRegionSelection();

  }

  Future<void> setIntroRegion() async {
    setIntroRegionSelection();
  }

  Future<void> skipIntroRegion() async {
    setIntroRegionSelection();
    emitEvent(SetIntroRegionEvent(SetIntroRegionEventType.onSkip));
  }
}
