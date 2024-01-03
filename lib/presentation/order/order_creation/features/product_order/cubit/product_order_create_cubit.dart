import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../../../data/responses/category/category/category_response.dart';

part 'product_order_create_cubit.freezed.dart';

part 'product_order_create_state.dart';

@Injectable()
class ProductOrderCreateCubit extends BaseCubit<ProductOrderCreateBuildable,
    ProductOrderCreateListenable> {
  ProductOrderCreateCubit() : super(const ProductOrderCreateBuildable());

  void setName(String name) {
    build((buildable) => buildable.copyWith(name: name));
  }

  void setNegative(bool isNegotiate) {
    build((buildable) => buildable.copyWith(isNegotiate: isNegotiate));
  }

  void setDescription(String description) {
    build((buildable) => buildable.copyWith(description: description));
  }

  void setCategory(CategoryResponse? categoryResponse) {
    display.success("set category ");
    build(
        (buildable) => buildable.copyWith(categoryResponse: categoryResponse));
  }

  void setFromPrice(String fromPrice) {
    build((buildable) => buildable.copyWith(fromPrice: fromPrice));
  }

  void setToPrice(String toPrice) {
    build((buildable) => buildable.copyWith(toPrice: toPrice));
  }

  void setPhoneNumber(String phoneNumber) {
    build((buildable) => buildable.copyWith(phone: phoneNumber));
  }

  void setEmail(String email) {
    build((buildable) => buildable.copyWith(email: email));
  }

  void setUserAddress(UserAddressResponse userAddressResponse) {
    display.success("address set");
    build((buildable) =>
        buildable.copyWith(userAddressResponse: userAddressResponse));
  }
}
