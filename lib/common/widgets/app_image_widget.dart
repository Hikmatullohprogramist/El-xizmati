import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppImageWidget extends StatelessWidget {
  AppImageWidget({super.key, required this.images});

  final List<String> images;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            physics: BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.grey, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: controller,
                count: images.length,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  type: WormType.thin,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
