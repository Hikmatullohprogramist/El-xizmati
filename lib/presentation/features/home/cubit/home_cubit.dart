import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.adStorage) : super(PageState()) {
    init();
  }

  final AdStorage adStorage;

  Future<void> init() async {
    adStorage.listenable().addListener(() {
      int favoritesCount = adStorage.favoriteAds.length;
      updateState((state) => state.copyWith(favoriteAdsCount: favoritesCount));

      int cartAdsCount = adStorage.cartAds.length;
      updateState((state) => state.copyWith(cartAdsCount: cartAdsCount));
    });
  }
}
