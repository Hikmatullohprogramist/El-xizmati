import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';

part 'setting_cubit.freezed.dart';

part 'setting_state.dart';

@injectable
class SettingCubit extends BaseCubit<SettingBuildable, SettingListenable> {
  SettingCubit() : super(const SettingBuildable());
}
