import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_builder.dart';
import 'package:onlinebozor/common/core/base_event.dart';
import 'package:onlinebozor/common/core/base_state.dart';
import 'package:onlinebozor/common/di/injection.dart';

import '../colors/static_colors.dart';

abstract class BasePage<CUBIT extends Cubit<BaseState<STATE, EVENT>>, STATE,
    EVENT> extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  void onWidgetCreated(BuildContext context) {}
  
  void onEventEmitted(BuildContext context, EVENT event) {}

  Widget onWidgetBuild(BuildContext context, STATE state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CUBIT>(
      create: (_) => getIt<CUBIT>(),
      child: Builder(
        builder: (context) {
          onWidgetCreated(context);

          return BaseListener<CUBIT, STATE, EVENT>(
            onEventEmitted: (event) => onEventEmitted(context, event),
            widget: BaseBuilder<CUBIT, STATE, EVENT>(onWidgetBuild: onWidgetBuild),
          );
        },
      ),
    );
  }

  CUBIT cubit(BuildContext context) {
    return context.read<CUBIT>();
  }

  STATE state(BuildContext context) {
    return context.read<STATE>();
  }

  EVENT event(BuildContext context) {
    return context.read<EVENT>();
  }

  void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: true,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: StaticColors.dodgerBlue),
              ],
            ),
          ),
        );
      },
    );
  }
}
