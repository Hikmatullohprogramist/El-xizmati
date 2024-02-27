import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';

part 'settings_cubit.freezed.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends BaseCubit<SettingsBuildable, SettingsListenable> {
  SettingsCubit() : super(const SettingsBuildable());
}
