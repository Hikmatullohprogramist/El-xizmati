import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';
import 'package:onlinebozor/presentation/common/search/cubit/search_cubit.dart';

@RoutePage()
class SearchPage
    extends BasePage<SearchCubit, SearchBuildable, SearchListenable> {
  SearchPage({super.key});

  final textController = TextEditingController();

  @override
  Widget builder(BuildContext context, SearchBuildable state) {
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
              onSubmitted: (value) {
                context.read<SearchCubit>().getSearchResult(value);
              },
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration.collapsed(
                  hintText: 'Искать товары и категории',
                  hintStyle: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 12,
                  )),
              controller: textController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
            )),
            InkWell(
                onTap: () {
                  final value = textController.text;
                  context.read<SearchCubit>().getSearchResult(value);
                },
                child: Assets.images.iconSearch
                    .svg(color: Colors.blueAccent, width: 24, height: 24)),
            SizedBox(width: 8),
            InkWell(
              onTap: () => textController.clear(),
              child: Assets.images.icClear.svg(width: 24, height: 24),
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
        loadingState: state.appLoadingState,
        onStartWidget: Center(child: Text("Qidirishni boshlang")),
        onEmptyWidget: Center(child: Text("Hech nima topilmadi")),
        child: ListView.builder(
          itemCount: state.searchResult.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                context.router.push(AdDetailRoute());
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
