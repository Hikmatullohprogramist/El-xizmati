import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'ad_search_cubit.freezed.dart';

part 'ad_search_state.dart';

@injectable
class AdSearchCubit
    extends BaseCubit<AdSearchBuildable, AdSearchListenable> {
  AdSearchCubit() : super(AdSearchBuildable());
}
