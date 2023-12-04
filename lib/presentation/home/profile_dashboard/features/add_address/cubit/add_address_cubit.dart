import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'add_address_cubit.freezed.dart';

part 'add_address_state.dart';

@injectable
class AddAddressCubit
    extends BaseCubit<AddAddressBuildable, AddAddressListenable> {
  AddAddressCubit() : super(AddAddressBuildable());

  void setAddressName(String addressName) {
    build((buildable) => buildable.copyWith(addressName: addressName));
  }
}
