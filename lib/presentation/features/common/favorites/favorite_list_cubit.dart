import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'favorite_list_cubit.freezed.dart';
part 'favorite_list_state.dart';

@injectable
class FavoriteListCubit extends BaseCubit<FavoriteListState, FavoriteListEvent> {
  FavoriteListCubit() : super(FavoriteListState());
}
