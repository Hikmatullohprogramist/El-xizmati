import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppImageWidget extends StatelessWidget {
  AppImageWidget({super.key, required this.images, required this.onClick});

  final List<String> images;
  final Function(String image) onClick;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F7FC),
      height: 360,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            physics: BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    onClick("");
                  },
                  child: Container(
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
                      placeholder: (context, url) => Center(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ));
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
