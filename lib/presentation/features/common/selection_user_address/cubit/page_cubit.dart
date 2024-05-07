import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

import '../../../../../../core/enum/enums.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._userAddressRepository) : super(PageState()) {
    getItems();
  }

  final UserAddressRepository _userAddressRepository;

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
