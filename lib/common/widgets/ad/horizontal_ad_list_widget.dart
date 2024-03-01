import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models/ad/ad.dart';
import '../../enum/enums.dart';
import '../../gen/assets/assets.gen.dart';
import '../favorite/ad_favorite_widget.dart';
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
    if (loadingState.name == "success") {
      return horizontalAdListWidget();
    } else {
      return shimmer();
    }
  }

  Widget horizontalAdListWidget() {
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
  Widget shimmer() {
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
            return SizedBox(
              height: 342,
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(color: Color(0xFFF6F7FC)),
                      child: Stack(children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[350]!,
                          highlightColor: Colors.grey[200]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),

                      ])),
                  SizedBox(height: 12),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: 15,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          height: 22,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[350]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          height: 22,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
