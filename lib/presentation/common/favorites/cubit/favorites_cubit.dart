import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/core/base_cubit_new.dart';


part 'favorites_cubit.freezed.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit
    extends BaseCubit<FavoritesBuildable, FavoritesListenable> {
  FavoritesCubit() : super(FavoritesBuildable());
}
