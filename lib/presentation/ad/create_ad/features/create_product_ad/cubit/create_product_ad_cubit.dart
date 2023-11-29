import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'create_product_ad_cubit.freezed.dart';

part 'create_product_ad_state.dart';

@Injectable()
class CreateProductAdCubit
    extends BaseCubit<CreateProductAdBuildable, CreateProductAdListenable> {
  CreateProductAdCubit() : super(const CreateProductAdBuildable());
}
