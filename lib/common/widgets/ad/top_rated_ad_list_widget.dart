import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad/top_rated_ad_widget.dart';
import 'package:onlinebozor/common/widgets/ad/top_rated_ad_widget_shimmer.dart';

import '../../../domain/models/ad/ad.dart';
import '../../enum/enums.dart';

class TopRatedAdListWidget extends StatelessWidget {
  const TopRatedAdListWidget({
    super.key,
    required this.ads,
    required this.onItemClicked,
    required this.onOnClickBuyClicked,
    required this.onFavoriteClicked,
    required this.loadingState,
  });

  final List<Ad> ads;
  final Function(Ad ad) onOnClickBuyClicked;
  final Function(Ad ad) onFavoriteClicked;
  final Function(Ad ad) onItemClicked;
  final LoadingState loadingState;


  @override
  Widget build(BuildContext context) {
    if(loadingState.name=="success"){
      return topRatedAdListWidget();
    }else{
      return shimmer();
    }

  }
  Widget topRatedAdListWidget(){
    return SizedBox(
      height: 144,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ads.length,
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          return TopRatedAdWidget(
            ad: ads[index],
            onItemClicked: onItemClicked,
            onOnClickBuyClicked: onOnClickBuyClicked,
            onFavoriteClicked: onFavoriteClicked,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10);
        },
      ),
    );
  }
  Widget shimmer(){
    return SizedBox(
      height: 144,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ads.length,
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          return TopRatedAdWidgetShimmer();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10);
        },
      ),
    );
  }
}
