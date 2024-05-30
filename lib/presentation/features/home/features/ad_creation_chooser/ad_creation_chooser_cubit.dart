import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'ad_creation_chooser_cubit.freezed.dart';
part 'ad_creation_chooser_state.dart';

@Injectable()
class AdCreationChooserCubit
    extends BaseCubit<AdCreationChooserState, AdCreationChooserEvent> {
  final StateRepository _stateRepository;

  AdCreationChooserCubit(
    this._stateRepository,
  ) : super(AdCreationChooserState()) {
    isUserLoggedIn();
  }

  Future<void> isUserLoggedIn() async {
    final isUserLoggedIn = _stateRepository.isAuthorized();
    updateState((state) => state.copyWith(isLogin: isUserLoggedIn));
  }
}
