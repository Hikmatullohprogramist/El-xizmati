import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../colors/static_colors.dart';
import '../divider/custom_diverder.dart';


extension ProfilViewShimmer on Widget{
   Widget profilShimmer(){
     return SingleChildScrollView(
       physics: BouncingScrollPhysics(),
       child: Container(
         color: StaticColors.backgroundColor,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             SizedBox(height: 12),
             Container(
               color: Colors.white,
               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(width: 100,height: 15,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5)),)),
                   SizedBox(height: 16),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Shimmer.fromColors(
                         baseColor: StaticColors.shimmerBaseColor,
                         highlightColor: StaticColors.shimmerHighLightColor,
                         child: Container(
                           height: 64,
                           width: 64,
                           margin: EdgeInsets.only(top: 6),
                           padding: EdgeInsets.all(12),
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10)),
                         ),
                       ),
                       SizedBox(width: 16),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           SizedBox(height: 8),
                           Row(
                             children: [
                               Shimmer.fromColors(
                                   baseColor: StaticColors.shimmerBaseColor,
                                   highlightColor: StaticColors.shimmerHighLightColor,
                                   child: Container(width: 220,height: 13,decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(5)),)),
                               SizedBox(width: 8),
                             ],
                           ),
                           SizedBox(height: 20,),
                           Row(
                             children: [
                               Shimmer.fromColors(
                                   baseColor: StaticColors.shimmerBaseColor,
                                   highlightColor: StaticColors.shimmerHighLightColor,
                                   child: Container(width: 67,height: 20,decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(5)),)),
                               SizedBox(width: 10),
                               Shimmer.fromColors(
                                   baseColor: StaticColors.shimmerBaseColor,
                                   highlightColor: StaticColors.shimmerHighLightColor,
                                   child: Container(width: 67,height: 20,decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(5)),)),
                             ],
                           )
                         ],
                       )
                     ],
                   ),
                   SizedBox(height: 6),
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(height: 36,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(5)),)),

                 ],
               ),
             ),
             ///build body 1
             SizedBox(height: 12,),
             Container(
               color: Colors.white,
               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///
                 SizedBox(height: 8),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///
                 SizedBox(height: 8),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///

                 SizedBox(height: 8),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///

                 SizedBox(height: 8),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///

                 SizedBox(height: 8),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 75,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 6),
                 Shimmer.fromColors(
                     baseColor: StaticColors.shimmerBaseColor,
                     highlightColor: StaticColors.shimmerHighLightColor,
                     child: Container(width: 175,height: 15,decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(7)),)),
                 SizedBox(height: 8),
                 CustomDivider(),
                 ///




               ]),
             ),
             /// build body 2
             SizedBox(height: 12,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 16),
               color: Colors.white,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 18),
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(width: 120,height: 18,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(7)
                       ),)),
                   SizedBox(height: 18),
                   OutlinedButton(
                     style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       side: BorderSide(
                           color: Color(0xFFAEB2CD)),
                     ),
                     onPressed: () {
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       child: Row(children: [
                         Shimmer.fromColors(
                           baseColor: StaticColors.shimmerBaseColor,
                           highlightColor: StaticColors.shimmerHighLightColor,
                           child: Container(
                             width: 32,
                             height: 32,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white),
                           ),
                         ),
                         SizedBox(width: 16),
                         Shimmer.fromColors(
                             baseColor: StaticColors.shimmerBaseColor,
                             highlightColor: StaticColors.shimmerHighLightColor,
                             child: Container(height: 20,width: 180,decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(9)
                             ),)),

                       ]),
                     ),
                   ),
                   SizedBox(height: 10),
                   OutlinedButton(
                     style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       side: BorderSide(
                           color: Color(0xFFAEB2CD)),
                     ),
                     onPressed: () {
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       child: Row(children: [
                         Shimmer.fromColors(
                           baseColor: StaticColors.shimmerBaseColor,
                           highlightColor: StaticColors.shimmerHighLightColor,
                           child: Container(
                             width: 32,
                             height: 32,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white),
                           ),
                         ),
                         SizedBox(width: 16),
                         Shimmer.fromColors(
                             baseColor: StaticColors.shimmerBaseColor,
                             highlightColor: StaticColors.shimmerHighLightColor,
                             child: Container(height: 20,width: 180,decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(9)
                             ),)),

                       ]),
                     ),
                   ),
                   SizedBox(height: 10),
                   OutlinedButton(
                     style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.white,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       side: BorderSide(
                           color: Color(0xFFAEB2CD)),
                     ),
                     onPressed: () {
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       child: Row(children: [
                         Shimmer.fromColors(
                           baseColor: StaticColors.shimmerBaseColor,
                           highlightColor: StaticColors.shimmerHighLightColor,
                           child: Container(
                             width: 32,
                             height: 32,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white),
                           ),
                         ),
                         SizedBox(width: 16),
                         Shimmer.fromColors(
                             baseColor: StaticColors.shimmerBaseColor,
                             highlightColor: StaticColors.shimmerHighLightColor,
                             child: Container(height: 20,width: 180,decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(9)
                             ),)),

                       ]),
                     ),
                   ),
                   SizedBox(height: 12),
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(width: 300,height: 14,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(7)
                       ),)),
                   SizedBox(height: 5,),
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(width: 150,height: 14,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(7)
                       ),)),
                   SizedBox(height: 15),
                   Shimmer.fromColors(
                       baseColor: StaticColors.shimmerBaseColor,
                       highlightColor: StaticColors.shimmerHighLightColor,
                       child: Container(width: double.infinity,height: 50,decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(7)
                       ),)),

                   SizedBox(height: 18),
                 ],
               ),
             )
           ],
         ),
       ),
     );
   }
}
