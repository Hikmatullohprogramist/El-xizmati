import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/auth/set_language/cubit/set_language_cubit.dart';

@RoutePage()
class SetLanguagePage extends BasePage<SetLanguageCubit, SetLanguageBuildable,
    SetLanguageListenable> {
  const SetLanguagePage({super.key});

  @override
  Widget builder(BuildContext context, SetLanguageBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Auth")],
                )
              ]),
        ),
      ),
    );
  }
}
