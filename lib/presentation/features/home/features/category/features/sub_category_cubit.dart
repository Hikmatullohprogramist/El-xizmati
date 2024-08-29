import 'package:El_xizmati/data/datasource/network/sp_response/category/category_response/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'sub_category_cubit.freezed.dart';
part 'sub_category_state.dart';

@Injectable()
class SubCategoryCubit extends BaseCubit<SubCategoryState, SubCategoryEvent> {
  SubCategoryCubit() : super(SubCategoryState());

  void setInitialParams(int parentId, List<Results> items) {
    updateState((state) => state.copyWith(
          parentId: parentId,
          items: items,
          loadState: items.isEmpty ? LoadingState.empty : LoadingState.success,
        ));
  }
}
