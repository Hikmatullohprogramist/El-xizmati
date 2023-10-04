import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'payment_transaction_filter_cubit.freezed.dart';

part 'payment_transaction_filter_state.dart';

@Injectable()
class PaymentTransactionFilterCubit extends BaseCubit<
    PaymentTransactionFilterBuildable, PaymentTransactionFilterListenable> {
  PaymentTransactionFilterCubit()
      : super(const PaymentTransactionFilterBuildable());
}
