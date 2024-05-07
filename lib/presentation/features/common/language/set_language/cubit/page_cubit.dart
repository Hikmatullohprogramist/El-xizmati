import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._stateRepository) : super(const PageState());

  final StateRepository _stateRepository;

  Future<void> setLanguage(Language language) async {
    await _stateRepository.setLanguage(language);
    // emitEvent(PageEvent(PageEventType.navigationAuthStart));
  }
}
