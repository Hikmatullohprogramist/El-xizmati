import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../data/repositories/user_address_repository.dart';

part 'selection_user_address_cubit.freezed.dart';

part 'selection_user_address_state.dart';

@Injectable()
class SelectionUserAddressCubit extends BaseCubit<SelectionUserAddressBuildable,
    SelectionUserAddressListenable> {
  SelectionUserAddressCubit(this._repository)
      : super(const SelectionUserAddressBuildable()) {
    getItems();
  }

  final UserAddressRepository _repository;

  Future<void> getItems() async {
    try {
      final items = await _repository.getUserAddresses();
      updateState(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.success,
          items: items,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }
  }
}
