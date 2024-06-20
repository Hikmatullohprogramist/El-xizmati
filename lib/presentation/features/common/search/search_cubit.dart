import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState, SearchEvent> {
  final AdRepository _adRepository;

  SearchCubit(this._adRepository) : super(SearchState());

  Future<void>? _future;

  Future<void> setSearchQuery(String? query) async {
    _future?.ignore();
    if (query == null || query.trim().isEmpty) {
      updateState((state) => state.copyWith(
            loadingState: LoadingState.initial,
          ));
      return;
    }
    _future = _adRepository
        .getSearch(query)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                loadingState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          if (data.isNotEmpty) {
            updateState((state) => state.copyWith(
                  searchResult: data,
                  loadingState: LoadingState.success,
                ));
          } else {
            updateState((state) => state.copyWith(
                  loadingState: LoadingState.empty,
                ));
          }
        })
        .onError((error) {
          logger.e("error = $error");
          updateState((state) => state.copyWith(
                loadingState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
