import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppImageWidget extends StatelessWidget {
  AppImageWidget({super.key, required this.images, required this.invoke});

  final List<String> images;
  final Function(int position) invoke;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 440,
      child: Column(
        children: [
          Container(
            color: Color(0xFFF6F7FC),
            child: SizedBox(
              height: 420,
              child: PageView.builder(
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () => invoke(index),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) => Center(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ));
                },
              ),
            ),
          ),
          SizedBox(height: 12),
          SmoothPageIndicator(
            controller: controller,
            count: images.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.normal,
            ),
          ),
        ],
      ),
    );
  }
}
