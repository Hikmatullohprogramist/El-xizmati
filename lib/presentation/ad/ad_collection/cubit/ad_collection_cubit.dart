import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'ad_collection_cubit.freezed.dart';

part 'ad_collection_state.dart';

@injectable
class AdCollectionCubit
    extends BaseCubit<AdCollectionBuildable, AdCollectionListenable> {
  AdCollectionCubit() : super(AdCollectionBuildable());
}
