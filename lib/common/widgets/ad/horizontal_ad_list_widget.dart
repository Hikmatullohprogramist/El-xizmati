import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad/horizontal_ad_shimmer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models/ad/ad.dart';
import '../../enum/enums.dart';
import 'horizontal_ad_widget.dart';

class HorizontalAdListWidget extends StatelessWidget {
  const HorizontalAdListWidget({
    super.key,
    required this.ads,
    required this.onItemClicked,
    required this.onFavoriteClicked,
    required this.loadingState,
  });

  final List<Ad> ads;
  final Function(Ad ad) onItemClicked;
  final Function(Ad ad) onFavoriteClicked;
  final LoadingState loadingState;

  @override
  Widget build(BuildContext context) {
    return loadingState == LoadingState.loading
        ? _buildLoadingBody()
        : _buildSuccessBody();
  }

  Widget _buildSuccessBody() {
    return SizedBox(
      height: 285,
      child: Align(
        alignment: Alignment.centerLeft,
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
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SizedBox(
      height: 285,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          padding: EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return HorizontalAddListShimmer();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
