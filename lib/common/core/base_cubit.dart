import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/core/base_state.dart';
import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/widgets/display/display.dart';

abstract class BaseCubit<STATE, EVENT> extends Cubit<BaseState<STATE, EVENT>> {
  late STATE currentState;

  final log = getIt<Logger>();
  final display = getIt<Display>();

  BaseCubit(STATE initialState) : super(BaseState(state: initialState)) {
    currentState = initialState;
  }

  updateState(STATE Function(STATE state) updateState) {
    currentState = updateState(currentState);
    emit(BaseState(state: currentState));
  }

  emitEvent(EVENT event) {
    emit(BaseState(event: event));
    updateState((buildable) => buildable);
  }
}
