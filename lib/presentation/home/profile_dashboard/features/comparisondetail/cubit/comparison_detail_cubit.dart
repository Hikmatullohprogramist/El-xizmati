import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'comparison_detail_cubit.freezed.dart';

part 'comparison_detail_state.dart';

@injectable
class ComparisonDetailCubit
    extends BaseCubit<ComparisonDetailBuildable, ComparisonDetailListenable> {
  ComparisonDetailCubit() : super(ComparisonDetailBuildable());
}
