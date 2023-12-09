import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/features/category/features/cubit/sub_category_cubit.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import '../../../../../domain/util.dart';

@RoutePage()
class SubCategoryPage extends BasePage<SubCategoryCubit, SubCategoryBuildable,
    SubCategoryListenable> {
  const SubCategoryPage(this.subCategoryId, this.title, {super.key});

  final int subCategoryId;
  final String title;

  @override
  void init(BuildContext context) {
    context.read<SubCategoryCubit>().getCategories(subCategoryId);
  }

  @override
  Widget builder(BuildContext context, SubCategoryBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: title.w(500).s(16).c(context.colors.textPrimary),
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: Assets.images.icArrowLeft.svg(),
        ),
      ),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.categoriesState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            return AppCategoryWidget(
                invoke: (CategoryResponse categoryResponse) {
                  context.router.push(AdListRoute(
                      adListType: AdListType.popularCategoryProduct,
                      keyWord: categoryResponse.key_word,
                      title: categoryResponse.name,
                      sellerTin: null));
                },
                category: state.categories[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1, indent: 54, color: Color(0xFFE5E9F3));
          },
        ),
      ),
    );
  }
}
