import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/repositories/user_address_repository.dart';
import 'package:El_xizmati/domain/models/user/user_address.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

import '../../../../../core/enum/enums.dart';

part 'user_address_selection_cubit.freezed.dart';
part 'user_address_selection_state.dart';

@Injectable()
class UserAddressSelectionCubit
    extends BaseCubit<UserAddressSelectionState, UserAddressSelectionEvent> {
  final UserAddressRepository _userAddressRepository;

  UserAddressSelectionCubit(this._userAddressRepository)
      : super(UserAddressSelectionState()) {
    getItems();
  }

  Future<void> getItems() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final items = await _userAddressRepository.getUserAddresses();
      var isEmpty = items.isEmpty;
      updateState((state) => state.copyWith(
            loadState: isEmpty ? LoadingState.empty : LoadingState.success,
            items: items,
          ));
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }
}
