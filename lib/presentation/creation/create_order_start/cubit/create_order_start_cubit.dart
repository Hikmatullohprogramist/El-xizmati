import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'create_order_start_state.dart';

part 'user_order_start_cubit.freezed.dart';

@Injectable()
class CreateRequestStartCubit
    extends BaseCubit<CreateOrderStartBuildable, CreateOrderStartListenable> {
  CreateRequestStartCubit() : super(CreateOrderStartBuildable());
}
