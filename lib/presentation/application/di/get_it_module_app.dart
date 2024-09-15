import 'package:El_xizmati/presentation/features/common/sp_add_picture/add_picture_cubit.dart';
import 'package:El_xizmati/presentation/features/common/sp_set_intro/set_intro_region_cubit.dart';
import 'package:El_xizmati/presentation/features/home/features/my_profile/features/change_password/change_password_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/presentation/features/auth/registration/registration_cubit.dart';
import 'package:El_xizmati/presentation/features/auth/reset_password/reset_password_cubit.dart';
import 'package:El_xizmati/presentation/features/common/add_address/add_address_cubit.dart';
import 'package:El_xizmati/presentation/features/common/category_selection/category_selection_cubit.dart';
import 'package:El_xizmati/presentation/features/common/currency_selection/currency_selection_cubit.dart';
import 'package:El_xizmati/presentation/features/common/sp_language/set_language_cubit.dart';
import 'package:El_xizmati/presentation/features/common/notification/notification_list_cubit.dart';
import 'package:El_xizmati/presentation/features/common/payment_type_selection/payment_type_selection_cubit.dart';
import 'package:El_xizmati/presentation/features/common/region_selection/region_selection_cubit.dart';
import 'package:El_xizmati/presentation/features/common/report/submit_report_cubit.dart';
import 'package:El_xizmati/presentation/features/common/set_region/set_region_cubit.dart';
import 'package:El_xizmati/presentation/features/common/unit_selection/unit_selection_cubit.dart';
import 'package:El_xizmati/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_cubit.dart';
import 'package:El_xizmati/presentation/features/home/features/cart/cart_cubit.dart';
import 'package:El_xizmati/presentation/features/home/features/category/category_cubit.dart';
import 'package:El_xizmati/presentation/features/home/features/my_profile/profile_cubit.dart';
import 'package:El_xizmati/presentation/features/home/home_cubit.dart';
import 'package:El_xizmati/presentation/features/realpay/add_card/add_card_with_realpay_cubit.dart';
import 'package:El_xizmati/presentation/features/realpay/refill/refill_with_realpay_cubit.dart';
import 'package:El_xizmati/presentation/support/state_message/state_message_manager.dart';
import 'package:El_xizmati/presentation/support/state_message/state_message_manager_impl.dart';

import '../../features/auth/sp_otp_confirm/otp_confirmation_cubit.dart';
import '../../features/auth/sp_start/auth_start_cubit.dart';
import '../../features/home/features/my_profile/features/personal/personal_cubit.dart';
import '../../features/home/features/sp_main/features/ad_create/ad_create_cubit.dart';
import '../../features/home/features/sp_main/main_cubit.dart';

extension GetItModuleApp on GetIt {
  Future<void> appModule() async {
    registerLazySingleton(() => Logger());

    registerSingleton<StateMessageManager>(StateMessageManagerImpl());


    // auth
    registerFactory(() => OtpConfirmationCubit(get()));
    registerFactory(() => ResetPasswordCubit(get()));
    registerFactory(() => AuthStartCubit(get(), get()));
    registerFactory(() => RegistrationCubit(get()));

    // common
    registerFactory(() => AddAddressCubit(get(), get()));
    registerFactory(() => CategorySelectionCubit(get()));
    registerFactory(() => CurrencySelectionCubit(get()));
    registerFactory(() => SetLanguageCubit(get()));
    registerFactory(() => NotificationListCubit(get()));
    registerFactory(() => PaymentTypeSelectionCubit(get()));
    registerFactory(() => RegionSelectionCubit(get()));
    registerFactory(() => SubmitReportCubit(get()));
    registerFactory(() => SetRegionCubit(get(), get()));
    registerFactory(() => SetIntroCubit(get(), get()));
    registerFactory(() => UnitSelectionCubit(get()));


    // home
    registerFactory(() => HomeCubit(get()));
    registerFactory(() => CartCubit(get(), get()));
    registerFactory(() => CategoryCubit(get()));
    registerFactory(() => AdCreationChooserCubit(get()));

    // realpay
    registerFactory(() => AddCardWithRealpayCubit(get()));
    registerFactory(() => RefillWithRealpayCubit(get()));


    //SP
    registerFactory(()=> ProfileCubit(get()));
    registerFactory(()=> PersonalCubit());
    registerFactory(()=> AddPictureCubit());
    registerFactory(()=> ChangePasswordCubit());
    registerFactory(()=> MainCubit());
    registerFactory(()=> AdCreateCubit(get()));

    await allReady();
  }
}
