import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../common/core/base_cubit.dart';

part 'a_cubit.freezed.dart';

part 'a_state.dart';

@Injectable()
class ZZCubit extends BaseCubit<ZZBuildable, ZZListenable> {
  ZZCubit() : super(const ZZBuildable());
}
