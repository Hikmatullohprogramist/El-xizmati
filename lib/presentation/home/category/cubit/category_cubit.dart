import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'category_cubit.freezed.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends BaseCubit<CategoryBuildable, CategoryListenable> {
  CategoryCubit() : super(CategoryBuildable());
}
