import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppBannerWidget extends StatelessWidget {
  const AppBannerWidget({super.key, required this.list});

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        pageSnapping: false,
        physics: BouncingScrollPhysics(),
        controller: PageController(viewportFraction: 0.95, keepPage: true),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: CachedNetworkImage(
              imageUrl: list[index %  list.length],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
        // itemCount: pages.length,
        // itemBuilder: (_, index) {
        //   return pages[index % pages.length];
        // },
      ),
    );
  }
}
