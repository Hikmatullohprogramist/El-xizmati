import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../constants.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Color(0xFFDFE2E9),
                )),
            child: CachedNetworkImage(
              imageUrl: Constants.baseUrlForImage,
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
              placeholder: (context, url) => Center(),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Реклама".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 13),
              "12:34".w(500).s(12).c(Color(0xFF9EABBE))
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "-150 000 сум".w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 9),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: "Оплачено".w(500).s(10).c(Color(0xFF32B88B)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
