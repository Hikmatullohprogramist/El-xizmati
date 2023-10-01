import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_ads_cubit.freezed.dart';

part 'my_ads_state.dart';

@injectable
class MyAdsCubit extends BaseCubit<MyAdsBuildable, MyAdsListenable> {
  MyAdsCubit() : super(const MyAdsBuildable());
}
