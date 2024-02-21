import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_unit_cubit.freezed.dart';

part 'selection_unit_state.dart';

@Injectable()
class SelectionUnitCubit
    extends BaseCubit<SelectionUnitBuildable, SelectionUnitListenable> {
  SelectionUnitCubit(this._repository) : super(SelectionUnitBuildable()) {
    getUnits();
  }

  final AdCreationRepository _repository;

  Future<void> getUnits() async {
    try {
      final units = await _repository.getUnitsForCreationAd();
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
