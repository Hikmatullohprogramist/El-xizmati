import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'product_order_create_cubit.freezed.dart';

part 'product_order_create_state.dart';

@Injectable()
class ProductOrderCreateCubit extends BaseCubit<ProductOrderCreateBuildable, ProductOrderCreateListenable> {
  ProductOrderCreateCubit() : super(const ProductOrderCreateBuildable());
}
