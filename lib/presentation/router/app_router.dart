import 'package:El_xizmati/presentation/features/common/sp_language/set_language_page.dart';
import 'package:El_xizmati/presentation/features/common/sp_set_intro/set_intro_region_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/unit/unit_response.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/image/uploadable_file.dart';
import 'package:El_xizmati/domain/models/report/report_type.dart';
import 'package:El_xizmati/domain/models/user/user_address.dart';
import 'package:El_xizmati/presentation/features/auth/sp_otp_confirm/otp_confirmation_page.dart';
import 'package:El_xizmati/presentation/features/auth/registration/registration_page.dart';
import 'package:El_xizmati/presentation/features/auth/reset_password/reset_password_page.dart';
import 'package:El_xizmati/presentation/features/auth/sp_start/auth_start_page.dart';
import 'package:El_xizmati/presentation/features/common/add_address/add_address_page.dart';
import 'package:El_xizmati/presentation/features/common/category_selection/category_selection_page.dart';
import 'package:El_xizmati/presentation/features/common/currency_selection/currency_selection_page.dart';
import 'package:El_xizmati/presentation/features/common/image_viewer/image_viewer_page.dart';
import 'package:El_xizmati/presentation/features/common/image_viewer/locale_image_viewer_page.dart';
import 'package:El_xizmati/presentation/features/common/notification/notification_list_page.dart';
import 'package:El_xizmati/presentation/features/common/payment_type_selection/payment_type_selection_page.dart';
import 'package:El_xizmati/presentation/features/common/region_selection/region_selection_page.dart';
import 'package:El_xizmati/presentation/features/common/report/submit_report_page.dart';
import 'package:El_xizmati/presentation/features/common/set_region/set_region_page.dart';
import 'package:El_xizmati/presentation/features/common/unit_selection/unit_selection_page.dart';
import 'package:El_xizmati/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_page.dart';
import 'package:El_xizmati/presentation/features/home/features/cart/cart_page.dart';
import 'package:El_xizmati/presentation/features/home/features/category/category_page.dart';
import 'package:El_xizmati/presentation/features/home/features/my_profile/profile_page.dart';
import 'package:El_xizmati/presentation/features/home/home_page.dart';
import 'package:El_xizmati/presentation/features/realpay/add_card/add_card_with_realpay_page.dart';
import 'package:El_xizmati/presentation/features/realpay/refill/refill_with_realpay_page.dart';

import '../../data/datasource/network/sp_response/category/category_response/category_response.dart';
import '../features/common/sp_add_picture/add_picture_page.dart';
import '../features/home/features/cart/chat/chat/chat.dart';
import '../features/home/features/my_profile/features/about/about_page.dart';
import '../features/home/features/my_profile/features/change_password/change_password_page.dart';
import '../features/home/features/my_profile/features/language_theme/language_theme.dart';
import '../features/home/features/my_profile/features/notification/notification_page.dart';
import '../features/home/features/my_profile/features/personal/personal_page.dart';
import '../features/home/features/sp_main/features/ad_create/ad_create_page.dart';
import '../features/home/features/sp_main/main_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Language
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: false,
        ),
        // default region
        AutoRoute(
          page: SetIntroRoute.page,
          path: '/set_intro_region',
        ),

        /// Add address
        AutoRoute(
          page: AddAddressRoute.page,
          path: '/add_address',
        ),

        /// Auth
        AutoRoute(
          page: AuthStartRoute.page,
          path: "/auth_start",
        ),
        AutoRoute(
          page: OtpConfirmationRoute.page,
          path: '/confirmation',
        ),

        AutoRoute(
          page: ResetPasswordRoute.page,
          path: '/reset_password',
        ),
        AutoRoute(
          page: RegistrationRoute.page,
          path: '/registration',
        ),


        /// home
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
          children: [
            AutoRoute(
              page: MainRoute.page,
              path: 'main',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: CategoryRoute.page,
              path: 'category',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: AdCreationChooserRoute.page,
              path: 'create_ad_chooser',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: CartRoute.page,
              path: 'cart',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
              maintainState: false,
              keepHistory: false,
            )
          ],
        ),


        AutoRoute(
          page: NotificationListRoute.page,
          path: '/notification_list',
        ),
        AutoRoute(
          page: SetRegionRoute.page,
          path: '/set_region',
        ),

        /// image viewer
        AutoRoute(
          page: ImageViewerRoute.page,
          path: '/image_viewer',
        ),

        /// local image viewer
        AutoRoute(
          page: LocaleImageViewerRoute.page,
          path: '/local_image_viewer',
        ),


        /// RealPay Payment
        AutoRoute(
          page: RefillWithRealPayRoute.page,
          path: '/refill_with_realpay',
        ),

        /// RealPay Payment
        AutoRoute(
          page: AddCardWithRealPayRoute.page,
          path: '/add_card_with_realpay',
        ),

        AutoRoute(
          page: CategorySelectionRoute.page,
          path: '/category_selection',
        ),

        AutoRoute(
          page: PaymentTypeSelectionRoute.page,
          path: '/payment_type_selection',
        ),

        AutoRoute(
          page: RegionSelectionRoute.page,
          path: '/region_selection',
        ),



        AutoRoute(
          page: UnitSelectionRoute.page,
          path: '/unit_selection',
        ),

        AutoRoute(
          page: SubmitReportRoute.page,
          path: '/submit_report',
        ),
        AutoRoute(
          page: PersonalRoute.page,
          path: '/sp_profile_edit'
        ),
    AutoRoute(
          page: AddPictureRoute.page,
          path: '/sp_add_picture'
        ),
    AutoRoute(
          page: ChangePasswordRoute.page,
          path: '/sp_edit_password'
        ),
    AutoRoute(
          page: AdCreateRoute.page,
          path: '/sp_ad_create'
        ),
    AutoRoute(
          page: NotificationRoute.page,
          path: '/sp_notification'
        ),
    AutoRoute(
          page: LanguageThemeRoute.page,
          path: '/sp_notification'
        ),
    AutoRoute(
          page: AboutRoute.page,
          path: '/sp_about'
        ),
    AutoRoute(
          page: ChatRoute.page,
          path: '/sp_about'
        ),
      ];
}
