import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'service_favorites_cubit.freezed.dart';

part 'service_favorites_state.dart';

@injectable
class ServiceFavoritesCubit
    extends BaseCubit<ServiceFavoritesBuildable, ServiceFavoritesListenable> {
  ServiceFavoritesCubit() : super(const ServiceFavoritesBuildable());
}
