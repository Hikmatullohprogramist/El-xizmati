import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/repositories/state_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

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
    final isAuthorized = _stateRepository.isAuthorized();
    updateState((state) => state.copyWith(isAuthorized: isAuthorized));
  }
}
