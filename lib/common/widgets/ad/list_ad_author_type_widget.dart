import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../domain/models/ad/ad_author_type.dart';
import '../../gen/localization/strings.dart';

class ListAdAuthorTypeChipWidget extends StatelessWidget {
  const ListAdAuthorTypeChipWidget({
    super.key,
    required this.adAuthorType,
    required this.isHorizontal,
  });

  final AdAuthorType adAuthorType;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: switch (adAuthorType) {
          AdAuthorType.private => Color(0x28AEB2CD),
          AdAuthorType.business => Color(0x1E6546E7),
        },
      ),
      child: switch (adAuthorType) {
        AdAuthorType.private => Strings.adPropertyPersonal,
        AdAuthorType.business => Strings.adPropertyBiznes
      }
          .w(400)
          .s(isHorizontal ? 12 : 12)
          .c(context.colors.textTertiary),
    );
  }
}
