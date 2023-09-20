import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'ads_collection_cubit.freezed.dart';

part 'ads_collection_state.dart';

@injectable
class AdsCollectionCubit
    extends BaseCubit<AdsCollectionBuildable, AdsCollectionListenable> {
  AdsCollectionCubit() : super(AdsCollectionBuildable());
}
