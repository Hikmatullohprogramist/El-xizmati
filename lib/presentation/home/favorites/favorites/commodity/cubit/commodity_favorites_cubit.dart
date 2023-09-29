import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'commodity_favorites_cubit.freezed.dart';

part 'commodity_favorites_state.dart';

@injectable
class CommodityFavoritesCubit
    extends BaseCubit<CommodityFavoritesBuildable, CommodityFavoritesListenable> {
  CommodityFavoritesCubit() : super(const CommodityFavoritesBuildable());
}
