import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';
import 'package:onlinebozor/presentation/widgets/search/search_input_field.dart';

import 'search_cubit.dart';

@RoutePage()
class SearchPage extends BasePage<SearchCubit, SearchState, SearchEvent> {
  SearchPage({super.key});

  // final textController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, SearchState state) {
    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: context.backgroundGreyColor,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: Assets.images.icArrowLeft.svg(),
        ),
        actions: [
          Expanded(
            child: SearchInputField((query) {
              cubit(context).setSearchQuery(query);
            }),
          )
        ],
      ),
      body: LoaderStateWidget(
        isFullScreen: false,
        loadingState: state.loadingState,
        initialBody: Center(child: Text(Strings.searchInitialMessage)),
        loadingBody: Center(child: CircularProgressIndicator()),
        emptyBody: Center(child: Text(Strings.commonEmptyMessage)),
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
                          .c(context.textPrimary)
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
