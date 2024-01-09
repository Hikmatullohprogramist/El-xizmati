import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/address/address_empty_widget.dart';
import 'package:onlinebozor/common/widgets/address/address_widget.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_address/cubit/user_addresses_cubit.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../data/responses/address/user_address_response.dart';

@RoutePage()
class UserAddressesPage extends BasePage<UserAddressesCubit,
    UserAddressesBuildable, UserAddressesListenable> {
  const UserAddressesPage({super.key});

  @override
  void listener(BuildContext context, UserAddressesListenable state) {
    switch (state.effect) {
      case UserAddressesEffect.success:
        () {};
      case UserAddressesEffect.editUserAddress:
        context.router.replace(AddAddressRoute(address: state.address));
    }
  }

  @override
  Widget builder(BuildContext context, UserAddressesBuildable state) {
    void edit(UserAddressResponse address) {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext buildContext) {
            return Container(
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Strings.userAddressAction
                                  .w(500)
                                  .s(16)
                                  .c(Color(0xFF41455E)))),
                      IconButton(
                          onPressed: () {
                            Navigator.of(buildContext).pop();
                          },
                          icon:
                              Assets.images.icClose.svg(width: 24, height: 24))
                    ],
                  ),
                  SizedBox(width: 32),
                  InkWell(
                    onTap: () {
                      Navigator.of(buildContext).pop();
                      context
                          .read<UserAddressesCubit>()
                          .editUserAddress(address);
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icEdit.svg(width: 24, height: 24),
                            SizedBox(width: 10),
                            Strings.userAddressEdit.s(14).c(Color(0xFF5C6AC3))
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<UserAddressesCubit>()
                          .updateMainAddress(address);
                      Navigator.of(buildContext).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icStar.svg(
                                width: 24,
                                height: 24,
                                color: context.colors.iconGrey),
                            SizedBox(width: 10),
                            Strings.userAddressSetAsMain
                                .w(500)
                                .s(14)
                                .c(Color(0xFF41455E))
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<UserAddressesCubit>()
                          .deleteUserAddress(address);
                      Navigator.of(buildContext).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icDelete.svg(width: 24, height: 24),
                            SizedBox(width: 10),
                            Strings.userAddressRemove
                                .w(500)
                                .s(14)
                                .c(Color(0xFF5C6AC3))
                          ],
                        )),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: CommonButton(
                      onPressed: () {
                        Navigator.of(buildContext).pop();
                      },
                      child:
                          Strings.userAddressClose.w(600).s(14).c(Colors.white),
                    ),
                  )
                ]),
              ),
            );
          });
    }

    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () =>
                  context.router.push(AddAddressRoute(address: null)),
              child: Strings.userAddressAdd.w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        backgroundColor: Colors.white,
        title: Strings.userAddressMyAddress
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: PagedGridView<int, UserAddressResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.adsPagingController!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: width / height,
          crossAxisSpacing: 16,
          mainAxisExtent: 156,
          crossAxisCount: 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<UserAddressResponse>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Strings.loadingStateError
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CommonButton(
                        onPressed: () {},
                        type: ButtonType.elevated,
                        child: Strings.loadingStateRetrybutton.w(400).s(15))
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return AddressEmptyWidget(callBack: () {
              context.router.push(DashboardRoute());
            });
          },
          newPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          newPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => AppAddressWidgets(
            listener: () {},
            address: item,
            listenerEdit: () {
              edit(item);
            },
          ),
        ),
      ),
    );
  }
}
