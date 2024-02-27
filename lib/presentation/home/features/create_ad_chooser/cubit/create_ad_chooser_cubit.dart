import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/state_repository.dart';
import '../../../../common/language/change_language/cubit/change_language_cubit.dart';

part 'create_ad_chooser_cubit.freezed.dart';

part 'create_ad_chooser_state.dart';

@Injectable()
class CreateAdChooserCubit
    extends BaseCubit<CreateAdChooserBuildable, CreateAdChooserListenable> {
  CreateAdChooserCubit(this.stateRepository) : super(CreateAdChooserBuildable()){
    isLogin();

  }
  final StateRepository stateRepository;

  Future<void> isLogin() async {
    final isLogin = await stateRepository.isLogin() ?? false;
    build((buildable) => buildable.copyWith(isLogin: isLogin));
  }

}

