import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/theme_mode_preferences.dart';
import 'package:onlinebozor/domain/models/theme/app_theme_mode.dart';
import 'package:onlinebozor/presentation/application/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/stream_controllers/app_theme_mode_stream_controller.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_manager.dart';
import 'package:onlinebozor/presentation/support/state_message/state_snack_bar_exts.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';

class Application extends StatefulWidget {
  const Application({
    super.key,
  });

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final AppThemeModeStreamController appThemeModeStreamController = getIt.get();

  final ThemeModePreferences _themeModePreferences = getIt.get();
  final LanguagePreferences _languagePreferences = getIt.get();

  late ThemeMode _themeMode;
  StreamSubscription<AppThemeMode>? _themeSubscription;

  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    _themeMode = _themeModePreferences.appThemeMode.themeMode;
    _themeSubscription = appThemeModeStreamController.listen((event) {
      setState(() {
        _themeMode = event.themeMode;
      });
    });
  }

  @override
  void dispose() {
    _themeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Inter',
              useMaterial3: false,
              colorScheme: _getLightModeColorScheme(),
            ),
            darkTheme: ThemeData(
              fontFamily: 'Inter',
              useMaterial3: false,
              brightness: Brightness.dark,
              colorScheme: _getDarkModeColorScheme(),
            ),
            themeMode: _themeMode,
            routerConfig: _appRouter.config(
              deepLinkBuilder: (_) => DeepLink(
                _languagePreferences.isLanguageSelected
                    ? [HomeRoute()]
                    : [SetLanguageRoute()],
              ),
              navigatorObservers: () => [ChuckerFlutter.navigatorObserver],
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
          Builder(
            builder: (context) {
              _initStateMessageManager(context);

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _initStateMessageManager(BuildContext context) {
    final stateMessageManager = getIt<StateMessageManager>();

    stateMessageManager.setListeners(
      onShowBottomSheet: (m) => showStateMessageBottomSheet(context, m),
      onShowSnackBar: (m) => context.showStateMessageSnackBar(m),
    );
  }

  ColorScheme _getLightModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
      primary: Color(0xFF5C6AC4),
      secondary: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF000000),
      surface: Color(0xFFF3F3F3),
      onSurface: Color(0xFF000000),
    );
    // return ColorScheme(
    //   brightness: Brightness.light,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFFFFFFF),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFFFFFFFF),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xFFDFE2E9),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFFB3E5FC),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFB00020),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFFFFFFFF),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFFFFFFFF),
    //   // General background color for the app
    //   onBackground: Color(0xFF000000),
    //   // Color used for text/icons on background
    //   surface: Color(0xFFF3F3F3),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFF000000),
    //   // Color used for text/icons on surfaces
    // );
  }

  ColorScheme _getDarkModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: Color(0xFF5C6AC4),
      secondary: Color(0xFF000000),
      background: Color(0xFF121212),
      onBackground: Color(0xFFE0E0E0),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFE0E0E0),
    );
    // return ColorScheme(
    //   brightness: Brightness.dark,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFF000000),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xAB121212),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFF404A80),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFCF6679),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFF000000),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFF121212),
    //   // General background color for the app
    //   onBackground: Color(0xFFE0E0E0),
    //   // Color used for text/icons on background
    //   surface: Color(0xFF333333),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFFE0E0E0),
    //   // Color used for text/icons on surfaces
    // );
  }

  void showStateMessageBottomSheet(BuildContext context, StateMessage message) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          color: context.bottomSheetColor,
          child: Container(
            color: context.bottomSheetColor,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Center(child: message.titleOrDefault.s(22).w(600)),
                SizedBox(height: 14),
                message.message.s(16).w(500).copyWith(
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                SizedBox(height: 32),
                CustomElevatedButton(
                  text: Strings.closeTitle,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(buildContext);
                  },
                  backgroundColor: context.colors.buttonPrimary,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}