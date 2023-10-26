import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/domain/model/search/search_response.dart';
import 'package:onlinebozor/domain/repo/common_repository.dart';

import '../../../../common/enum/AdRouteType.dart';

part 'search_cubit.freezed.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends BaseCubit<SearchBuildable, SearchListenable> {
  SearchCubit(this._repository) : super(SearchBuildable());

  final CommonRepository _repository;

  Future<void> getSearchResult(String request) async {
    try {
      build((buildable) =>
          buildable.copyWith(appLoadingState: AppLoadingState.LOADING));
      final result = await _repository.getSearch(request);
      if (result.isNotEmpty) {
        build((buildable) => buildable.copyWith(
            searchResult: result, appLoadingState: AppLoadingState.SUCCESS));
      } else {
        build((buildable) =>
            buildable.copyWith(appLoadingState: AppLoadingState.EMPTY));
      }
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }
}
