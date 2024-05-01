import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';

class AdCartBuyWidget extends StatefulWidget {
  const AdCartBuyWidget({
    super.key,
    required this.height,
    required this.isAddedCart,
    required this.onCartClicked,
    required this.onBuyClicked,
  });

  final double height;
  final bool isAddedCart;
  final VoidCallback onCartClicked;
  final VoidCallback onBuyClicked;

  @override
  State<StatefulWidget> createState() => _AdCartBuyWidget();
}

class _AdCartBuyWidget extends State<AdCartBuyWidget> {
  bool _isAddedCart = false;

  @override
  void initState() {
    super.initState();
    _isAddedCart = widget.isAddedCart;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Flexible(
          child: CustomElevatedButton(
            text: Strings.adDetailOpenCart,
            onPressed: () => widget.onCartClicked,
          ),
        ),
        SizedBox(width: 8),
        Flexible(
          child: CustomElevatedButton(
            text: Strings.adBuyByOneClick,
            backgroundColor: StaticColors.majorelleBlue.withOpacity(0.8),
            onPressed: () => widget.onBuyClicked(),
          ),
        ),
      ]),
    );
  }
}
