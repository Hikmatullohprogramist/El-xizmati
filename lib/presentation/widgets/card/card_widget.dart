import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/card/user_card.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.userCard,
    required this.onRefillClicked,
    required this.onHistoryClicked,
    required this.onRefreshClicked,
    required this.onSettingsClicked,
  });

  final UserCard userCard;
  final VoidCallback onRefillClicked;
  final VoidCallback onHistoryClicked;
  final VoidCallback onRefreshClicked;
  final Function(UserCard card) onSettingsClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 209,
      decoration: BoxDecoration(
        // color: context.colors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            userCard.cardName
                                .s(14)
                                .w(400)
                                .c(context.textPrimaryInverse),
                            SizedBox(height: 16),
                            "${priceMaskFormatter.formatDouble(userCard.balance)} ${Strings.currencyUzb}"
                                .s(20)
                                .w(600)
                                .c(context.textPrimaryInverse),
                          ],
                        ),
                        SizedBox(width: 8),
                        userCard.cardLogo.svg(width: 42, height: 42)
                      ],
                    ),
                    SizedBox(height: 16),
                    userCard.cardHolder
                        .s(16)
                        .w(500)
                        .c(context.textPrimaryInverse)
                        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 12),
                    userCard.cardPan.s(14).w(400).c(context.textPrimaryInverse),
                    SizedBox(height: 12),
                  ],
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: context.appBarColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: userCard.isDeposit
                    ? _buildDepositActions(context)
                    : _buildCardActions(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () => onRefillClicked(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Assets.images.icCardRefill.svg(
                  color: context.iconPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () => onRefreshClicked(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Assets.images.icCardRefresh.svg(
                  color: context.iconPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () => onHistoryClicked(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Assets.images.icCardHistory.svg(
                  color: context.iconPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildCardActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              onTap: () {
                onSettingsClicked(userCard);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Assets.images.icCardSettings.svg(
                  color: context.iconPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
