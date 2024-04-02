import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository repository;

  Future<void> getItems() async {
    try {
      final items = await repository.getCurrenciesForCreationAd();
      log.i(items.toString());
      updateState(
        (state) => state.copyWith(
          items: items,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}
