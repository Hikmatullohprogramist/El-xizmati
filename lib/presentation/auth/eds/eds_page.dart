import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/eds/cubit/eds_cubit.dart';

class EdsPage extends BasePage<EdsCubit, EdsBuildable, EdsListenable> {
  const EdsPage({super.key});

  @override
  Widget builder(BuildContext context, EdsBuildable state) {
    return Center(
      child: Text(""),
    );
  }
}
