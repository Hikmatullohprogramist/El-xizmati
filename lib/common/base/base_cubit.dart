import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/widgets/display/display.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_state.dart';
import 'package:logger/logger.dart';

abstract class BaseCubit<BUILDABLE, LISTENABLE>
    extends Cubit<BaseState<BUILDABLE, LISTENABLE>> {
  late BUILDABLE buildable;

  final log = getIt<Logger>();
  final display = getIt<Display>();

  BaseCubit(BUILDABLE initialBuildable)
      : super(BaseState(buildable: initialBuildable)) {
    buildable = initialBuildable;
  }

  build(BUILDABLE Function(BUILDABLE buildable) builder) {
    buildable = builder(buildable);
    emit(BaseState(buildable: buildable));
  }

  invoke(LISTENABLE listenable) {
    emit(BaseState(listenable: listenable));
    build((buildable) => buildable);
  }
}
