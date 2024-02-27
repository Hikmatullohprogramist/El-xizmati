import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/core/base_state.dart';
import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/widgets/display/display.dart';

abstract class BaseCubit<STATE, EVENT> extends Cubit<BaseState<STATE, EVENT>> {
  late STATE buildable;

  final log = getIt<Logger>();
  final display = getIt<Display>();

  BaseCubit(STATE initialState)
      : super(BaseState(state: initialState)) {
    buildable = initialState;
  }

  updateState(STATE Function(STATE buildable) builder) {
    buildable = builder(buildable);
    emit(BaseState(state: buildable));
  }

  emitEvent(EVENT listenable) {
    emit(BaseState(event: listenable));
    updateState((buildable) => buildable);
  }
}
