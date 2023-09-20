import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/common/search/cubit/search_cubit.dart';

@RoutePage()
class SearchPage
    extends BasePage<SearchCubit, SearchBuildable, SearchListenable> {
  const SearchPage({super.key});

  @override
  Widget builder(BuildContext context, SearchBuildable state) {
    return Scaffold(body: Center(child: Text("Search Page")));
  }
}
