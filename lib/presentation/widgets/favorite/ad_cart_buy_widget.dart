import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              widget.onCartClicked();
              vibrateAsHapticFeedback();
              setState(() => _isAddedCart = !_isAddedCart);
            },
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
                color: StaticColors.buttonColor.withOpacity(
                  _isAddedCart ? .2 : .2,
                ),
              ),
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Center(
                child: _isAddedCart
                    ? Assets.images.adCartAdded.svg()
                    : Assets.images.adCartNotAdded.svg(),
              ),
            ),
          ),
        ),
        SizedBox(width: 3),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              widget.onBuyClicked();
              vibrateAsHapticFeedback();
            },
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(2),
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2),
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(8),
                ),
                color: StaticColors.majorelleBlue.withOpacity(.15),
              ),
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Center(child: Assets.images.adOrder.svg()),
            ),
          ),
        ),
      ],
    );
  }
}
