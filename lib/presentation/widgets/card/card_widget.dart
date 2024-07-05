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
    required this.onHistoryClicked,
    required this.onRefillClicked,
    required this.onReloadDepositClicked,
    required this.onSettingsClicked,
    required this.onDeleteClicked,
  });

  final UserCard userCard;
  final VoidCallback onHistoryClicked;
  final VoidCallback onRefillClicked;
  final VoidCallback onReloadDepositClicked;
  final Function(UserCard card) onSettingsClicked;
  final Function(UserCard card) onDeleteClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      userCard.cardName
                          .s(14)
                          .w(400)
                          .c(context.textPrimaryInverse),
                      SizedBox(height: 16),
                      "${priceMaskFormatter.formatDouble(userCard.balance)} ${Strings.currencyUzs}"
                          .s(20)
                          .w(600)
                          .c(context.textPrimaryInverse),
                      SizedBox(height: 16),
                      userCard.cardHolder
                          .s(15)
                          .w(500)
                          .c(context.textPrimaryInverse)
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 12),
                      userCard.cardPan
                          .s(14)
                          .w(400)
                          .c(context.textPrimaryInverse),
                      SizedBox(height: 12),
                    ],
                  ),
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
        userCard.cardLogo.svg(
          width: userCard.isDeposit ? 32 : 24,
          height: userCard.isDeposit ? 32 : 24,
        ),
        Spacer(),
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
        Visibility(visible: false, child: SizedBox(width: 8)),
        Visibility(
          visible: false,
          child: Container(
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                onTap: () => onReloadDepositClicked(),
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
        ),
        Visibility(visible: false, child: SizedBox(width: 8)),
        Visibility(
          visible: false,
          child: Container(
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
        userCard.cardLogo.svg(
          width: userCard.isDeposit ? 32 : 24,
          height: userCard.isDeposit ? 32 : 24,
        ),
        Spacer(),
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
                onDeleteClicked(userCard);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                child: Assets.images.icDelete.svg(),
              ),
            ),
          ),
        ),
        Visibility(visible: false, child: SizedBox(width: 8)),
        Visibility(
          visible: false,
          child: Container(
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
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
