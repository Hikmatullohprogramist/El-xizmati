import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'order_creation_cubit.freezed.dart';

part 'order_creation_state.dart';

@Injectable()
class OrderCreationCubit extends BaseCubit<OrderCreationBuildable, OrderCreationListenable> {
  OrderCreationCubit() : super(const OrderCreationBuildable());
}
