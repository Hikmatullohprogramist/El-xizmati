import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'setting_state.dart';
part 'setting_cubit.freezed.dart';

@injectable
class SettingCubit extends BaseCubit<SettingBuildable, SettingListenable> {
  SettingCubit() : super(const SettingBuildable());
}
