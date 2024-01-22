import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_app_bar.dart';
import 'package:onlinebozor/presentation/ad/ad_list/cubit/ad_list_cubit.dart';

import '../../../common/core/base_page.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/ad/vertical_ad_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../domain/models/ad.dart';
import '../../../domain/util.dart';

@RoutePage()
class AdListPage
    extends BasePage<AdListCubit, AdListBuildable, AdListListenable> {
  const AdListPage(this.adListType, this.keyWord, this.title,
      {super.key, this.sellerTin, this.adId, this.collectiveType});

  final AdListType adListType;
  final String? keyWord;
  final String? title;
  final int? sellerTin;
  final int? adId;
  final AdType? collectiveType;

  @override
  void init(BuildContext context) {
    context
        .read<AdListCubit>()
        .setInitiallyDate(keyWord, adListType, sellerTin, adId, collectiveType);
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
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CommonAppBar(() {
        context.router.pop();
      }, title ?? ""),
      backgroundColor: Colors.white,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.adsPagingController!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: width / height,
            crossAxisSpacing: 16,
            mainAxisSpacing: 24,
            crossAxisCount: 2,
            mainAxisExtent: 315),
        builderDelegate: PagedChildBuilderDelegate<Ad>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Strings.loadingStateError
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CommonButton(
                        onPressed: () {},
                        type: ButtonType.elevated,
                        child: Strings.loadingStateRetry.w(400).s(15))
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              width: double.infinity,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.blue)),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(child: Text(Strings.loadingStateNoItemFound)));
          },
          newPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              width: double.infinity,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.blue)),
            );
          },
          newPageErrorIndicatorBuilder: (_) {
            return SizedBox(
                height: 160,
                child: Center(
                    child: CircularProgressIndicator(color: Colors.blue)));
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => VerticalAdWidget(
            ad: item,
            invokeFavorite: (value) =>
                context.read<AdListCubit>().addFavorite(value),
            invoke: (value) {
              context.router.push(AdDetailRoute(adId: value.id));
            },
          ),
        ),
      ),
    );
  }
}
