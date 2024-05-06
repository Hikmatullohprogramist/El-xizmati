import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/state_repository.dart';
import '../../../../../domain/models/language/language.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getLanguage();
  }

  StateRepository repository;

  Future<void> selectLanguage(Language language) async {
    updateState((state) => state.copyWith(language: language));
    await repository.setLanguage(states.language!);
  }

  Future<void> getLanguage() async {
    try {
      final language = await repository.getLanguage();
      updateState((state) => state.copyWith(language: language));
    } catch (e) {
      log.w(e);
    }
  }
}
