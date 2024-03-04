import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/common_repository.dart';
import '../../../../../data/responses/category/category/category_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getCategories();
  }

  final CommonRepository repository;

  Future<void> getCategories() async {
    try {
      final allCategories = await repository.getCategories();
      final categories = allCategories.where((e) => e.parent_id == 0).toList();
      log.i(allCategories.toString());
      updateState((state) => state.copyWith(
          items: categories,
          loadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      display.error(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}
