import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../common/enum/loading_enum.dart';
import '../../../../data/model/search/search_response.dart';
import '../../../../domain/repository/common_repository.dart';

part 'search_cubit.freezed.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends BaseCubit<SearchBuildable, SearchListenable> {
  SearchCubit(this._repository) : super(SearchBuildable());

  final CommonRepository _repository;

  Future<void> getSearchResult(String request) async {
    try {
      build((buildable) =>
          buildable.copyWith(appLoadingState: AppLoadingState.loading));
      final result = await _repository.getSearch(request);
      if (result.isNotEmpty) {
        build((buildable) => buildable.copyWith(
            searchResult: result, appLoadingState: AppLoadingState.success));
      } else {
        build((buildable) =>
            buildable.copyWith(appLoadingState: AppLoadingState.empty));
      }
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}
