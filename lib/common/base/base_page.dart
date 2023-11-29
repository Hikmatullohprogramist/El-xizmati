// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:onlinebozor/common/base/base_builder.dart';
// import 'package:onlinebozor/common/base/base_listener.dart';
// import 'package:onlinebozor/common/base/base_state.dart';
// import 'package:onlinebozor/common/di/injection.dart';
//
// abstract class BasePage<CUBIT extends Cubit<BaseState<BUILDABLE, LISTENABLE>>,
//     BUILDABLE, LISTENABLE> extends StatelessWidget {
//   const BasePage({Key? key}) : super(key: key);
//
//   void listener(BuildContext context, LISTENABLE state) {}
//
//   Widget builder(BuildContext context, BUILDABLE state);
//
//   void init(BuildContext context) {}
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CUBIT>(
//       create: (_) => getIt<CUBIT>(),
//       child: Builder(
//         builder: (context) {
//           init(context);
//           return BaseListener<CUBIT, BUILDABLE, LISTENABLE>(
//             listener: (listenable) => listener(context, listenable),
//             child: BaseBuilder<CUBIT, BUILDABLE, LISTENABLE>(builder: builder),
//           );
//         },
//       ),
//     );
//   }
// }
