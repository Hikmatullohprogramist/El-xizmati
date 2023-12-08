import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../../presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';
import '../../gen/assets/assets.gen.dart';
import '../../gen/localization/strings.dart';
import '../../router/app_router.dart';
import 'product_and_service.dart';

class AppRootProductAndService extends StatelessWidget {
  const AppRootProductAndService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AppProductAndService(
              invoke: () {
                context.router.push(AdCollectionRoute(
                  collectiveType: CollectiveType.product,
                ));
              },
              color: Color(0xFFB9A0FF),
              title: Strings.productsTitle,
              endColorGradient: Color(0xFFAFA2DA),
              image: Assets.images.pngImages.commondity.image(),
              startColorGradient: Color(0xFF9570FF),
            ),
          ),
          Flexible(
            flex: 1,
            child: AppProductAndService(
              invoke: () {
                context.router.push(
                    AdCollectionRoute(collectiveType: CollectiveType.service));
              },
              color: Color(0xFFFFBB79),
              title: Strings.servicesTitle,
              endColorGradient: Color(0xFFF0C49A),
              image: Assets.images.pngImages.service.image(),
              startColorGradient: Color(0xFFF7993D),
            ),
          )
        ],
      ),
    );
  }
}
