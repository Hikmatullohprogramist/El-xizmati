import 'package:flutter/cupertino.dart';

import '../../../domain/models/ad.dart';
import 'ad_horizontal_widget.dart';

class AdGroupWidget extends StatelessWidget {
  const AdGroupWidget(
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
      height: 347,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ads.length,
        padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
        itemBuilder: (context, index) {
          return AppAdHorizontalWidget(
            invokeFavorite: invokeFavorite,
            invoke: invoke,
            ad: ads[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}
