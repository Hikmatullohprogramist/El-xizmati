import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';
import '../../gen/assets/assets.gen.dart';
import '../../gen/localization/strings.dart';
import '../../router/app_router.dart';
import 'product_or_service.dart';

class ProductAndService extends StatelessWidget {
  const ProductAndService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(width: 16),
          Expanded(
            child: ProductOrService(
              invoke: () {
                context.router.push(
                  AdCollectionRoute(collectiveType: CollectiveType.product),
                );
              },
              color: Color(0xFFB9A0FF),
              title: Strings.productsTitle,
              endColorGradient: Color(0xFFAFA2DA),
              image: Assets.images.pngImages.commondity.image(),
              startColorGradient: Color(0xFF9570FF),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ProductOrService(
              invoke: () {
                context.router.push(
                  AdCollectionRoute(collectiveType: CollectiveType.service),
                );
              },
              color: Color(0xFFFFBB79),
              title: Strings.servicesTitle,
              endColorGradient: Color(0xFFF0C49A),
              image: Assets.images.pngImages.service.image(),
              startColorGradient: Color(0xFFF7993D),
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}
