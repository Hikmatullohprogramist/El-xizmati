// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:onlinebozor/core/extensions/text_extensions.dart';
// import 'package:onlinebozor/core/gen/localization/strings.dart';
//
// import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
//
// class SearchInputAppBar extends AppBar implements PreferredSizeWidget {
//   final VoidCallback listenerSearch;
//   final TextInputControl listenerNotification;
//
//   SearchInputAppBar({
//     super.key,
//     required this.listenerSearch,
//     required this.listenerNotification,
//   }) : super(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 16, top: 8, bottom: 8, right: 12),
//               child: Assets.images.icArrowLeft.svg(),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
//                 child: Container(
//                   height: 40,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(width: 1, color: Color(0xFFE5E9F3)),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   child: Row(children: [
//                     Expanded(
//                       child: TextField(
//                         autofocus: true,
//                         onSubmitted: (value) {
//                           // cubit(context).getSearchResult(value);
//                         },
//                         style: TextStyle(
//                           color: context.colors.textPrimary,
//                           fontSize: 14,
//                         ),
//                         decoration: InputDecoration.collapsed(
//                             hintText: Strings.adSearchHint,
//                             hintStyle: TextStyle(
//                               color: context.colors.textSecondary,
//                               fontSize: 12,
//                             )),
//                         controller: searchTextController,
//                         cursorColor: Colors.black,
//                         keyboardType: TextInputType.text,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         final value = searchTextController.text;
//                         // cubit(context).getSearchResult(value);
//                       },
//                       child: Assets.images.iconSearch
//                           .svg(color: Colors.blueAccent, width: 24, height: 24),
//                     ),
//                     SizedBox(width: 8),
//                     InkWell(
//                       onTap: () => searchTextController.clear(),
//                       child: Assets.images.icClose.svg(width: 24, height: 24),
//                     )
//                   ]),
//                 ),
//               ),
//             ),
//           ],
//           backgroundColor: context.themeOf.backgroundColor,
//           elevation: 0.5,
//           toolbarHeight: 64,
//         );
// }
