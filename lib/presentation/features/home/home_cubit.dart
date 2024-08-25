import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState, HomeEvent> {
  final AdEntityDao _adEntityDao;

  HomeCubit(this._adEntityDao) : super(HomeState()) {
    initListeners();
  }

  Future<void> initListeners() async {
    try {
      _adEntityDao.watchCartAdsCount().listen((count) {
        updateState((state) => state.copyWith(cartAdsCount: count ?? 0));
      });
    } catch (e) {
      logger.w("watchCartAdsCount error = $e");
    }
  }
}
