import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'sub_category_cubit.freezed.dart';
part 'sub_category_state.dart';

@Injectable()
class SubCategoryCubit extends BaseCubit<SubCategoryState, SubCategoryEvent> {
  SubCategoryCubit() : super(SubCategoryState());

  void setInitialParams(int parentId, List<Category> items) {
    updateState((state) => state.copyWith(
          parentId: parentId,
          items: items,
          loadState: items.isEmpty ? LoadingState.empty : LoadingState.success,
        ));
  }
}
