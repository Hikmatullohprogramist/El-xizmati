import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/repositories/common_repository.dart';
import '../../../../../../data/responses/category/category/category_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState());

  final CommonRepository repository;

  Future<void> getCategories(int id) async {
    try {
      final allCategories = await repository.getCategories();
      final categories = allCategories.where((e) => e.parent_id == id).toList();
      log.i(allCategories.toString());
      updateState(
        (state) => state.copyWith(
          items: categories,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}
