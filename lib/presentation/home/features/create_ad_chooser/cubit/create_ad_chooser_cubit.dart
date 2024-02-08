import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'create_ad_chooser_cubit.freezed.dart';

part 'create_ad_chooser_state.dart';

@Injectable()
class CreateAdChooserCubit
    extends BaseCubit<CreateAdChooserBuildable, CreateAdChooserListenable> {
  CreateAdChooserCubit() : super(CreateAdChooserBuildable());
}
