import 'package:flutter/material.dart';

import '../../../domain/models/ad/ad.dart';
import 'horizontal_ad_widget.dart';

class HorizontalAdListWidget extends StatelessWidget {
  const HorizontalAdListWidget({
    super.key,
    required this.ads,
    required this.onItemClicked,
    required this.onFavoriteClicked,
  });

  final List<Ad> ads;
  final Function(Ad ad) onItemClicked;
  final Function(Ad ad) onFavoriteClicked;

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
            ad: ads[index],
            onItemClicked: onItemClicked,
            onFavoriteClicked: onFavoriteClicked,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
