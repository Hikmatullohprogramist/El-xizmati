import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'user_ads_cubit.freezed.dart';
part 'user_ads_state.dart';

@injectable
class UserAdsCubit extends BaseCubit<UserAdsState, UserAdsEvent> {
  UserAdsCubit() : super(const UserAdsState());
}
