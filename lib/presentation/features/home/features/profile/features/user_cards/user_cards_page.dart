import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/card/user_card.dart';
import 'package:onlinebozor/presentation/features/realpay/add_card/add_card_with_realpay_page.dart';
import 'package:onlinebozor/presentation/features/realpay/refill/refill_with_realpay_page.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/card/card_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/card/card_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'user_cards_cubit.dart';

@RoutePage()
class UserCardsPage
    extends BasePage<UserCardsCubit, UserCardsState, UserCardsEvent> {
  const UserCardsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, UserCardsState state) {
    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      appBar: ActionAppBar(
        titleText: Strings.myCardTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.cardAddTitle,
            onPressed: () => _showAddCardWithRealPayPage(context),
          )
        ],
      ),
      body: RefreshIndicator(
        displacement: 80,
        strokeWidth: 3,
        color: context.colors.primary,
        onRefresh: () async {
          cubit(context).reload();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10, bottom: 14),
          child: Column(
            children: [
              _buildDepositCard(context, state),
              _buildDebitCards(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepositCard(BuildContext context, UserCardsState state) {
    return LoaderStateWidget(
      isFullScreen: false,
      loadingState: state.depositState,
      loadingBody: CardShimmer(),
      successBody: _buildCardWidget(context, state, state.depositCard),
      onRetryClicked: () => cubit(context).getDepositCardBalance(),
    );
  }

  Widget _buildDebitCards(BuildContext context, UserCardsState state) {
    return LoaderStateWidget(
      isFullScreen: false,
      loadingState: state.cardsState,
      loadingBody: _buildLoadingBody(),
      successBody: _buildSuccessBody(context, state),
      onRetryClicked: () => cubit(context).getUserDebitCards(),
    );
  }

  Widget _buildLoadingBody() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return CardShimmer();
        },
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, UserCardsState state) {
    final cards = state.cards;
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.cards.length,
      itemBuilder: (context, index) {
        return _buildCardWidget(context, state, cards[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 0, height: 0);
      },
    );
  }

  Widget _buildCardWidget(
    BuildContext context,
    UserCardsState state,
    UserCard userCard,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
      child: CardWidget(
        userCard: userCard,
        onDeleteClicked: (card) {
          showYesNoBottomSheet(
            context,
            title: Strings.messageTitleWarning,
            message: Strings.cardDeletingMessage,
            noTitle: Strings.commonNo,
            onNoClicked: () {},
            yesTitle: Strings.commonYes,
            onYesClicked: () => cubit(context).removeCard(card),
          );
        },
        onHistoryClicked: () {},
        onRefillClicked: () => _showRefillWithRealPayPage(context),
        onReloadDepositClicked: () {},
        onSettingsClicked: (card) {},
      ),
    );
  }

  void _showRefillWithRealPayPage(BuildContext context) async {
    RefillWithRealPayPage page = RefillWithRealPayPage();
    var isSuccess = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return page;
      },
    );

    if (isSuccess is bool && isSuccess) {
      cubit(context).reload();
    }
  }

  void _showAddCardWithRealPayPage(BuildContext context) async {
    AddCardWithRealPayPage page = AddCardWithRealPayPage();
    var isSuccess = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return page;
      },
    );

    if (isSuccess is bool && isSuccess) {
      cubit(context).getUserDebitCards();
    }
  }
}
