import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/image/rounded_cached_network_image_widget.dart';

import '../../gen/assets/assets.gen.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.listener,
      required this.image,
      required this.listenerEdit});

  final VoidCallback listener;
  final VoidCallback listenerEdit;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: listener,
      child: Stack(
        children: [
          RoundedCachedNetworkImage(
            imageId: image,
            imageHeight: 160,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: IconButton(
                icon: Assets.images.icSetting.svg(height: 24, width: 24),
                onPressed: listenerEdit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
