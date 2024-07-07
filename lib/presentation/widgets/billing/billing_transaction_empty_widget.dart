import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

class BillingTransactionsEmptyWidget extends StatelessWidget {
  const BillingTransactionsEmptyWidget({super.key, required this.listener});

  final VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 120),
        Assets.images.pngImages.cardEmpty.image(),
        SizedBox(height: 48),
        "Hech qanday to'lovlar yo'q".w(500).s(16).c(context.textPrimary).copyWith(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start),
        SizedBox(height: 12),
        // Strings.cardEmptyDescripton
        //      .w(400)
        //      .s(12)
        //      .c(context.textPrimary)
        //      .copyWith(
        //        maxLines: 2,
        //        textAlign: TextAlign.center,
        //      ),
        //  SizedBox(height: 42),
        //  SizedBox(
        //      width: double.maxFinite,
        //      child: CommonButton(
        //        type: ButtonType.elevated,
        //        color: context.colors.buttonPrimary,
        //        onPressed: (){listener();},
        //        child: Row(
        //            mainAxisSize: MainAxisSize.min,
        //            mainAxisAlignment: MainAxisAlignment.center,
        //            children: [
        //              Icon(Icons.add),
        //              SizedBox(width: 10),
        //             Strings.cardAddCardTitle.w(500).s(14).c(Colors.white)
        //            ]),
        //      ))
      ]),
    ));
  }
}
