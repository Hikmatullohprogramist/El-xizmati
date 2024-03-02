import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../common/widgets/button/common_button.dart';

@RoutePage()
class LocaleImageViewerPage extends StatefulWidget {
  const LocaleImageViewerPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<XFile> images;
  final int initialIndex;

  @override
  _LocaleImageViewerPageState createState() => _LocaleImageViewerPageState();
}

class _LocaleImageViewerPageState extends State<LocaleImageViewerPage> {
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

    var pageController = PageController(initialPage: widget.initialIndex);

    return WillPopScope(
      onWillPop: () async {
        context.router.pop(widget.images);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PopScope(
          onPopInvoked: (didPop) {
            // if (didPop) {
            //   // context.router.pop(widget.images);
            //   AutoRouter.of(context).pop(widget.images);
            // }
          },
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                reverse: false,
                onPageChanged: onPageChanged,
                pageController: pageController,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(File(widget.images[index].path)),
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
                left: 12,
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
              Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CommonButton(
                          color: Colors.white,
                          type: ButtonType.elevated,
                          isEnabled: currentIndex != 0,
                          onPressed: () {
                            setState(() {
                              var item = widget.images.removeAt(currentIndex);
                              currentIndex = -1;
                              widget.images.insert(0, item);
                              pageController.jumpToPage(0);
                            });
                          },
                          text: (currentIndex == 0
                                  ? "Главное фото"
                                  : "Сделать главным")
                              .s(14)
                              .w(400)
                              .c(Colors.black)
                              .copyWith(textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CommonButton(
                          color: Colors.white,
                          type: ButtonType.elevated,
                          onPressed: () {
                            setState(() {
                              widget.images.removeAt(currentIndex);
                              if (widget.images.isEmpty) {
                                context.router.pop(widget.images);
                              }
                            });
                          },
                          text: "Удалить"
                              .s(14)
                              .w(400)
                              .c(Colors.black)
                              .copyWith(textAlign: TextAlign.center),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
