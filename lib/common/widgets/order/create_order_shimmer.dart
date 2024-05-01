import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../colors/static_colors.dart';
import '../divider/custom_diverder.dart';

class CreateOrderShimmer extends StatelessWidget {
  const CreateOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: StaticColors.shimmerBaseColor,
            highlightColor: StaticColors.shimmerHighLightColor,
            child: Container(
              color: context.primaryContainer,
              width: double.infinity,
              height: 120,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      margin: EdgeInsets.only(right: 220),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      margin: EdgeInsets.only(right: 120),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: StaticColors.shimmerBaseColor,
                              highlightColor:
                                  StaticColors.shimmerHighLightColor,
                              child: Container(
                                height: 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Shimmer.fromColors(
                              baseColor: StaticColors.shimmerBaseColor,
                              highlightColor:
                                  StaticColors.shimmerHighLightColor,
                              child: Container(
                                height: 15,
                                margin: EdgeInsets.only(right: 55),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 35,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 35,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      margin: EdgeInsets.only(right: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 15,
                      margin: EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomDivider()
                ],
              )),
        ],
      ),
    );
  }
}
