import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../../../data/responses/category/category/category_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(PageState());

  void setInitialParams(int parentId, List<CategoryResponse> items) {
    updateState((state) => state.copyWith(
          parentId: parentId,
          items: items,
          loadState: items.isEmpty ? LoadingState.empty : LoadingState.success,
        ));
  }
}
