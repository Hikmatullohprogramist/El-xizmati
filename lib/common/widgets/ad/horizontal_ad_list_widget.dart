import 'package:flutter/material.dart';

import '../../../domain/models/ad.dart';
import 'horizontal_ad_widget.dart';

class HorizontalAdListWidget extends StatelessWidget {
  const HorizontalAdListWidget(
      {super.key,
      required this.ads,
      required this.invoke,
      required this.invokeFavorite});

  final List<Ad> ads;
  final Function(Ad ad) invoke;
  final Function(Ad ad) invokeFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ads.length,
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          return HorizontalAdWidget(
            invokeFavorite: invokeFavorite,
            invoke: invoke,
            ad: ads[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
