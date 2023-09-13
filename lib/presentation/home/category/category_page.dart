import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';

import 'cubit/category_cubit.dart';

@RoutePage()
class CategoryPage
    extends BasePage<CategoryCubit, CategoryBuildable, CategoryListenable> {
  const CategoryPage({super.key});

  @override
  Widget builder(BuildContext context, CategoryBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
