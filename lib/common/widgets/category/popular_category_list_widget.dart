import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../enum/enums.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget({
    super.key,
    required this.categories,
    required this.invoke,
    required this.loadingState,
  });

  final List<PopularCategoryResponse> categories;
  final Function(PopularCategoryResponse category) invoke;
  final LoadingState loadingState;


  @override
  Widget build(BuildContext context) {
     if(loadingState.name=="success"){
       return popularCategoryListWidget();
     }else{
       return shimmer();
     }
  }
  Widget popularCategoryListWidget(){
    return SizedBox(
      height: 154,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return PopularCategoryHorizontal(
            category: categories[index],
            onItemClicked: invoke,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
  Widget shimmer(){
    return  SizedBox(
      height: 154,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return  Container(
            width: 124,
            decoration: BoxDecoration(
              color: Color(0xFFF6F7FC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.90, color: Color(0xFFE5E9F3)),
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 12),
                Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: ShapeDecoration(
                        shape: OvalBorder(),
                      color: Color(0xFFEDEEF0)
                    ),
                  
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[350]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Color(0xFFEDEEF0),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                CustomDivider(),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                   child:Shimmer.fromColors(
                     baseColor: Colors.grey[350]!,
                     highlightColor: Colors.grey[200]!,
                     child: Container(
                       height: 14,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(2),
                         color: Color(0xFFEDEEF0),

                       ),
                     ),
                   ) ,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
