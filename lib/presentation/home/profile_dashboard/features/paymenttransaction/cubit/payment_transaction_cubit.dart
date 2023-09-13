import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'payment_transaction_cubit.freezed.dart';

part 'payment_transaction_state.dart';

@injectable
class PaymentTransactionCubit extends BaseCubit<PaymentTransactionBuildable,
    PaymentTransactionListenable> {
  PaymentTransactionCubit() : super(PaymentTransactionBuildable());
}
