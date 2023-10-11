import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onlinebozor/common/di/injection.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/display/display_widget.dart';
import 'package:onlinebozor/domain/repo/state_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await configureDependencies();

  await EasyLocalization.ensureInitialized();
  var stateRepository = GetIt.instance<StateRepository>();
  var isLanguageSelection =
      await stateRepository.isLanguageSelection() ?? false;

  runApp(
    EasyLocalization(
      supportedLocales: Strings.supportedLocales,
      path: Assets.localization.translations,
      fallbackLocale: Strings.supportedLocales.first,
      assetLoader: CsvAssetLoader(),
      child: MyApp(
        isLanguageSelection: isLanguageSelection,
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLanguageSelection});

  final bool isLanguageSelection;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return DisplayWidget(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        routerConfig: _appRouter.config(initialRoutes: [
          if (isLanguageSelection) HomeRoute() else SetLanguageRoute()
        ]),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
