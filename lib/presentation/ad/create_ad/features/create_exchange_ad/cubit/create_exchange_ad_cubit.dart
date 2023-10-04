import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'create_exchange_ad_cubit.freezed.dart';

part 'create_exchange_ad_state.dart';

@Injectable()
class CreateExchangeAdCubit
    extends BaseCubit<CreateExchangeAdBuildable, CreateExchangeAdListenable> {
  CreateExchangeAdCubit() : super(const CreateExchangeAdBuildable());
}
