import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'ad_creation_start_cubit.freezed.dart';

part 'ad_creation_start_state.dart';

@Injectable()
class AdCreationStartCubit
    extends BaseCubit<AdCreationStartBuildable, AdCreationStartListenable> {
  AdCreationStartCubit() : super(AdCreationStartBuildable());
}
