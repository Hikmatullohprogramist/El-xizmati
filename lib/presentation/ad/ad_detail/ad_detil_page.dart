import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/widgets/app_image_widget.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';
import 'package:onlinebozor/presentation/ad/ad_detail/cubit/ad_detail_cubit.dart';

@RoutePage()
class AdDetailPage
    extends BasePage<AdDetailCubit, AdDetailBuildable, AdDetailListenable> {
  const AdDetailPage({super.key});

  @override
  Widget builder(BuildContext context, AdDetailBuildable state) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 24,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              )),
          actions: [AppFavoriteWidget(isSelected: false, onEvent: () {})]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageWidget(
              images: const [
                "https://api.online-bozor.uz/uploads/images/ff80818197d1375eb6232ea1",
                "https://api.online-bozor.uz/uploads/images/ff80818192f139ea4a6bd505",
                "https://api.online-bozor.uz/uploads/images/ff808181c5e63362532cb295",
                "https://api.online-bozor.uz/uploads/images/ff8081811b383adf10ac97b5",
              ],
            ),
            Divider(
              height: 1,
              color: Color(0xFFE5E9F3),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: []),
            )
          ],
        ),
      ),
    );
  }
}
