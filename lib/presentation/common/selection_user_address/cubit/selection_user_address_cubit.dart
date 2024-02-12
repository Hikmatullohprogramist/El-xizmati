import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/domain/repositories/user_address_repository.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_user_address_cubit.freezed.dart';

part 'selection_user_address_state.dart';

@Injectable()
class SelectionUserAddressCubit extends BaseCubit<SelectionUserAddressBuildable,
    SelectionUserAddressListenable> {
  SelectionUserAddressCubit(this._repository)
      : super(const SelectionUserAddressBuildable()) {
    getUserAddresses();
  }

  final UserAddressRepository _repository;

  Future<void> getUserAddresses() async {
    try {
      final userAddresses = await _repository.getUserAddresses();
      build(
        (buildable) => buildable.copyWith(
            userAddressState: LoadingState.success,
            userAddresses: userAddresses),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      display.error("server xatolik yuz beradi");
    }
  }

  void selectionUserAddress(UserAddressResponse userAddressResponse) {
    invoke(SelectionUserAddressListenable(SelectionUserAddressEffect.back,
        userAddressResponse: userAddressResponse));
  }
}
