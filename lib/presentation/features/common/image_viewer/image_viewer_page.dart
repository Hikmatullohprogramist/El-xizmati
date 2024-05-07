import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

@RoutePage()
class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage(
    this.initialIndex, {
    super.key,
    required this.images,
  });

  final List<String> images;
  final int initialIndex;

  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Desired status bar color
          statusBarIconBrightness: Brightness.light // Status bar icon color
          ));
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Default status bar color
          statusBarIconBrightness:
              Brightness.dark // Default status bar icon color
          ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height;
    double width;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            reverse: false,
            onPageChanged: onPageChanged,
            pageController: PageController(initialPage: currentIndex),
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.images[index]),
                initialScale: PhotoViewComputedScale.contained * 1,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.images[index]),
              );
            },
            itemCount: widget.images.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: double.infinity,
                height: height / 2,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: 24,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    context.router.pop(widget.images);
                  },
                  icon: Assets.images.icArrowLeft.svg(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
