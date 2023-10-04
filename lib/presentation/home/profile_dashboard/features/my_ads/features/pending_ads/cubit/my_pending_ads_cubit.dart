import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_pending_ads_cubit.freezed.dart';

part 'my_pending_ads_state.dart';

@Injectable()
class MyPendingAdsCubit
    extends BaseCubit<MyPendingAdsBuildable, MyPendingAdsListenable> {
  MyPendingAdsCubit() : super(const MyPendingAdsBuildable());
}
