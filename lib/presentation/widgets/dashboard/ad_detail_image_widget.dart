import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/widgets/image/rectangle_cached_network_image_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdDetailImageWidget extends StatelessWidget {
  AdDetailImageWidget({
    super.key,
    required this.images,
    required this.onClicked,
  });

  final List<String> images;
  final Function(int position) onClicked;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: controller,
            physics: BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              currentIndex = index;
              return InkWell(
                onTap: () => onClicked(index),
                child: RectangleCachedNetworkImage(imageId: images[index]),
              );
            },
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
    );
  }
}
