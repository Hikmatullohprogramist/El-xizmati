import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository) : super(PageState());

  final AdRepository _authRepository;

  Future<void> getSearchResult(String request) async {
    try {
      updateState(
        (state) => state.copyWith(loadingState: LoadingState.loading),
      );
      final result = await _authRepository.getSearch(request);
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
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      snackBarManager.error(e.toString());
    }
  }
}
