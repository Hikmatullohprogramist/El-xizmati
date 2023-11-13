import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_app_bar.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';
import 'package:onlinebozor/presentation/ad/ad_list/cubit/ad_list_cubit.dart';

import '../../../common/router/app_router.dart';
import '../../../common/widgets/ad/ad_widget.dart';
import '../../../common/widgets/common_button.dart';
import '../../../domain/model/ad_enum.dart';

@RoutePage()
class AdListPage
    extends BasePage<AdListCubit, AdListBuildable, AdListListenable> {
  const AdListPage(this.adListType, this.keyWord, {super.key});

  final AdListType adListType;
  final String? keyWord;

  @override
  void init(BuildContext context) {
    context.read<AdListCubit>().initiallyDate(keyWord, adListType);
  }

  @override
  void listener(BuildContext context, AdListListenable state) {
    switch (state.effect) {
      case AdListEffect.success:
        () {};
      case AdListEffect.navigationToAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget builder(BuildContext context, AdListBuildable state) {
    return Scaffold(
      appBar: CommonAppBar(() {
        context.router.pop();
      }, "E'lonlar"),
      backgroundColor: Colors.white,
      body: PagedGridView<int, AdModel>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.adsPagingController!,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 156 / 286,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<AdModel>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Strings.loadingStateError
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CommonButton(
                        onPressed: () {},
                        type: ButtonType.elevated,
                        child: Strings.loadingStateRetrybutton.w(400).s(15))
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return Center(child: Text(Strings.loadingStateNotitemfound));
          },
          newPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          newPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => AppAdWidget(
            result: item,
            onClickFavorite: (value) =>
                context.read<AdListCubit>().addFavorite(value),
            onClick: (value) {
              context.router.push(AdDetailRoute(adId: value.id));
            },
          ),
        ),
      ),
    );
  }
}
