import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_saved_orders_cubit.freezed.dart';

part 'my_saved_orders_state.dart';

@injectable
class MySavedOrdersCubit
    extends BaseCubit<MySavedOrdersBuildable, MySavedOrdersListenable> {
  MySavedOrdersCubit() : super(const MySavedOrdersBuildable());
}
