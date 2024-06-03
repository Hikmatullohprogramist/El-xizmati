import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState, HomeEvent> {
  // final AdStorage adStorage;

  HomeCubit() : super(HomeState()) {
    // init();
  }

  Future<void> init() async {
    // adStorage.listenable().addListener(() {
    //   int favoritesCount = adStorage.favoriteAds.length;
    //   updateState((state) => state.copyWith(favoriteAdsCount: favoritesCount));
    //
    //   int cartAdsCount = adStorage.cartAds.length;
    //   updateState((state) => state.copyWith(cartAdsCount: cartAdsCount));
    // });
  }
}
