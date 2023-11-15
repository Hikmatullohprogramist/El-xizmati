import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'order_create_state.dart';
part 'order_create_cubit.freezed.dart';

@Injectable()
class OrderCreateCubit extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit() : super(const OrderCreateBuildable());
}
