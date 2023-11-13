import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'cart_cubit.freezed.dart';
part 'cart_state.dart';

@injectable
class CartCubit extends BaseCubit<CartBuildable, CartListenable> {
  CartCubit() : super(CartBuildable());

  void checkBoxClick() {
    build((buildable) => buildable.copyWith(checkBox: !buildable.checkBox));
  }
}
