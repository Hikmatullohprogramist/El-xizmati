import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'wallet_filing_cubit.freezed.dart';

part 'wallet_filing_state.dart';

@injectable
class WalletFilingCubit
    extends BaseCubit<WalletFilingBuildable, WalletFilingListenable> {
  WalletFilingCubit() : super(const WalletFilingBuildable());
}
