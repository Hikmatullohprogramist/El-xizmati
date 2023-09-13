import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'ads_detail_cubit.freezed.dart';

part 'ads_detail_state.dart';

@injectable
class AdsDetailCubit
    extends BaseCubit<AdsDetailBuildable, AdsDetailListenable> {
  AdsDetailCubit() : super(AdsDetailBuildable());
}
