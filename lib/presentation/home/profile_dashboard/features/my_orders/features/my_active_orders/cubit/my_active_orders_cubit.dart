import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_active_orders_cubit.freezed.dart';

part 'my_active_orders_state.dart';

@injectable
class MyActiveOrdersCubit
    extends BaseCubit<MyActiveOrdersBuildable, MyActiveOrdersListenable> {
  MyActiveOrdersCubit() : super(const MyActiveOrdersBuildable());
}
