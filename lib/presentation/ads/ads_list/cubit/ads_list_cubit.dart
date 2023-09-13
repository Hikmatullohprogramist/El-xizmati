import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'ads_list_cubit.freezed.dart';

part 'ads_list_state.dart';

@injectable
class AdsListCubit extends BaseCubit<AdsListBuildable, AdsListListenable> {
  AdsListCubit() : super(AdsListBuildable());
}
