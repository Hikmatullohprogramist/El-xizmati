import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_pending_orders_cubit.freezed.dart';

part 'my_pending_orders_state.dart';

@injectable
class MyPendingOrdersCubit
    extends BaseCubit<MyPendingOrdersBuildable, MyPendingOrdersListenable> {
  MyPendingOrdersCubit() : super(const MyPendingOrdersBuildable());
}
