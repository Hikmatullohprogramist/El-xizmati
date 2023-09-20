import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

part 'eds_cubit.freezed.dart';

part 'eds_state.dart';

class EdsCubit extends BaseCubit<EdsBuildable, EdsListenable> {
  EdsCubit() : super(const EdsBuildable());
}
