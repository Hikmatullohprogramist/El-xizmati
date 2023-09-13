import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit() : super(DashboardBuildable());
}
