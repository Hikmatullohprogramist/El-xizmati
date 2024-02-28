import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/responses/search/search_response.dart';

part 'search_cubit.freezed.dart';

part 'search_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState());

  final AdRepository _repository;

  Future<void> getSearchResult(String request) async {
    try {
      updateState(
        (state) => state.copyWith(loadingState: LoadingState.loading),
      );
      final result = await _repository.getSearch(request);
      if (result.isNotEmpty) {
        updateState(
          (state) => state.copyWith(
            searchResult: result,
            loadingState: LoadingState.success,
          ),
        );
      } else {
        updateState(
          (state) => state.copyWith(loadingState: LoadingState.empty),
        );
      }
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}
