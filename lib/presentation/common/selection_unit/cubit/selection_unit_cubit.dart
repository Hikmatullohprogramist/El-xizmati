import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../domain/repositories/common_repository.dart';

part 'selection_unit_cubit.freezed.dart';

part 'selection_unit_state.dart';

@Injectable()
class SelectionUnitCubit
    extends BaseCubit<SelectionUnitBuildable, SelectionUnitListenable> {
  SelectionUnitCubit(this._repository) : super(SelectionUnitBuildable()) {
    getUnits();
  }

  final CommonRepository _repository;

  Future<void> getUnits() async {
    try {
      final units = await _repository.getUnits();
      log.i(units.toString());
      build((buildable) => buildable.copyWith(
            units: units,
            unitsState: LoadingState.success,
          ));
    } on DioException catch (exception) {
      log.e(exception.toString());
    }
  }
}
