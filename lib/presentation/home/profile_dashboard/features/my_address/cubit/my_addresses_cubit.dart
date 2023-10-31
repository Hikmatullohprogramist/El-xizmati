import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'my_addresses_cubit.freezed.dart';

part 'my_addresses_state.dart';

@Injectable()
class MyAddressesCubit
    extends BaseCubit<MyAddressesBuildable, MyAddressesListenable> {
  MyAddressesCubit() : super(MyAddressesBuildable());
}
