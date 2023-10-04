import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_active_ads_cubit.freezed.dart';

part 'my_active_ads_state.dart';

@Injectable()
class MyActiveAdsCubit
    extends BaseCubit<MyActiveAdsBuildable, MyActiveAdsListenable> {
  MyActiveAdsCubit() : super(const MyActiveAdsBuildable());
}
