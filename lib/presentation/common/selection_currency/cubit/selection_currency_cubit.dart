import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_currency_cubit.freezed.dart';

part 'selection_currency_state.dart';

@Injectable()
class SelectionCurrencyCubit
    extends BaseCubit<SelectionCurrencyBuildable, SelectionCurrencyListenable> {
  SelectionCurrencyCubit(this._repository)
      : super(SelectionCurrencyBuildable()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final items = await _repository.getCurrenciesForCreationAd();
      log.i(items.toString());
      updateState(
        (buildable) => buildable.copyWith(
          items: items,
          itemsLoadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }
  }
}
