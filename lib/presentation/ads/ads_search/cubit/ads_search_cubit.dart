import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'ads_search_cubit.freezed.dart';

part 'ads_search_state.dart';

@injectable
class AdsSearchCubit
    extends BaseCubit<AdsSearchBuildable, AdsSearchListenable> {
  AdsSearchCubit() : super(AdsSearchBuildable());
}
