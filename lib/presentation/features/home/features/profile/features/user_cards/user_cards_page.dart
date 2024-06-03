import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/features/realpay/add_card/add_card_with_realpay_page.dart';
import 'package:onlinebozor/presentation/features/realpay/refill/refill_with_realpay_page.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/card/card_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'user_cards_cubit.dart';

@RoutePage()
class UserCardsPage extends BasePage<UserCardsCubit, PageState, PageEvent> {
  const UserCardsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
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
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.depositState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(context, state),
        onRetryClicked: () => cubit(context).getDepositCardBalance(),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Center();
        },
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, PageState state) {
    return RefreshIndicator(
      displacement: 160,
      strokeWidth: 3,
      color: context.colors.primary,
      onRefresh: () async {
        cubit(context).reload();
      },
      child: SingleChildScrollView(
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.cards.length,
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          itemBuilder: (context, index) {
            return CardWidget(
              userCard: state.cards[index],
              onDeleteClicked: (card) {
                showYesNoBottomSheet(
                  context,
                  title: Strings.messageTitleWarning,
                  message: Strings.cardDeleteMessage,
                  noTitle: Strings.commonNo,
                  onNoClicked: () {},
                  yesTitle: Strings.commonYes,
                  onYesClicked: () {
                    cubit(context).removeCard(card);
                  },
                );
              },
              onHistoryClicked: () {},
              onRefillClicked: () => _showRefillWithRealPayPage(context),
              onReloadDepositClicked: () {},
              onSettingsClicked: (card) {},
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 16, height: 8);
          },
        ),
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
      cubit(context).getAddedCards();
    }
  }
}
