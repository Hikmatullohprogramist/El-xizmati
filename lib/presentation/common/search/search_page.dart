import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';
import 'package:onlinebozor/presentation/common/search/cubit/page_cubit.dart';

@RoutePage()
class SearchPage extends BasePage<PageCubit, PageState, PageEvent> {
  SearchPage({super.key});

  final textController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFE5E9F3)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(children: [
            Expanded(
              child: TextField(
                autofocus: true,
                onSubmitted: (value) {
                  cubit(context).getSearchResult(value);
                },
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration.collapsed(
                    hintText: Strings.adSearchHint,
                    hintStyle: TextStyle(
                      color: context.colors.textSecondary,
                      fontSize: 12,
                    )),
                controller: textController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
              ),
            ),
            InkWell(
                onTap: () {
                  final value = textController.text;
                  cubit(context).getSearchResult(value);
                },
                child: Assets.images.iconSearch
                    .svg(color: Colors.blueAccent, width: 24, height: 24)),
            SizedBox(width: 8),
            InkWell(
              onTap: () => textController.clear(),
              child: Assets.images.icClose.svg(width: 24, height: 24),
            )
          ]),
        ),
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: Assets.images.icArrowLeft.svg(),
        ),
        elevation: 0.5,
      ),
      body: LoaderStateWidget(
        isFullScreen: false,
        loadingState: state.loadingState,
        initialBody: Center(child: Text("Qidirishni boshlang")),
        emptyBody: Center(child: Text(Strings.loadingStateEmpty)),
        successBody: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: state.searchResult.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                context.router
                    .push(AdDetailRoute(adId: state.searchResult[index].id!));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Assets.images.iconSearch.svg(),
                    SizedBox(width: 12),
                    Flexible(
                      child: (state.searchResult[index].name ?? "")
                          .w(700)
                          .s(14)
                          .c(context.colors.textPrimary)
                          .copyWith(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
