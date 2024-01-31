import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_builder.dart';
import 'package:onlinebozor/common/core/base_listener.dart';
import 'package:onlinebozor/common/core/base_state.dart';
import 'package:onlinebozor/common/di/injection.dart';

abstract class BasePage<CUBIT extends Cubit<BaseState<BUILDABLE, LISTENABLE>>,
    BUILDABLE, LISTENABLE> extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  void listener(BuildContext context, LISTENABLE event) {}

  Widget builder(BuildContext context, BUILDABLE state);

  void init(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CUBIT>(
      create: (_) => getIt<CUBIT>(),
      child: Builder(
        builder: (context) {
          init(context);

          return BaseListener<CUBIT, BUILDABLE, LISTENABLE>(
            listener: (event) => listener(context, event),
            child: BaseBuilder<CUBIT, BUILDABLE, LISTENABLE>(builder: builder),
          );
        },
      ),
    );
  }

  CUBIT cubit(BuildContext context) {
    return context.read<CUBIT>();
  }

  BUILDABLE state(BuildContext context) {
    return context.read<BUILDABLE>();
  }

  LISTENABLE event(BuildContext context) {
    return context.read<LISTENABLE>();
  }
}
