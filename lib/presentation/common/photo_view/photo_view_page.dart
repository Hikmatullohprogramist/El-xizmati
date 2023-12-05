import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/common/photo_view/cubit/photo_view_cubit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

@RoutePage()
class PhotoViewPage
    extends BasePage<PhotoViewCubit, PhotoViewBuildable, PhotoViewListenable> {
  const PhotoViewPage({super.key, required this.lists});

  final List<String> lists;

  @override
  Widget builder(BuildContext context, PhotoViewBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Assets.images.icArrowLeft
                  .svg(height: 24, width: 24, color: Colors.white)),
        ),
        body: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(lists[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: PhotoViewHeroAttributes(tag: lists[index]),
            );
          },
          itemCount: lists.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: double.infinity,
              height: height / 2,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        ));

    //   Scaffold(
    //   body: PhotoView(
    //     imageProvider: NetworkImage(
    //         "https://api.online-bozor.uz/uploads/images/ff8081813071e7d6ad8969d0"),
    //   ),
    // );
  }
}
