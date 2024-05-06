import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../data/repositories/state_repository.dart';
import '../../../../../domain/models/language/language.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState());

  StateRepository repository;

  Future<void> setLanguage(Language language) async {
    await repository.setLanguage(language);
    // emitEvent(PageEvent(PageEventType.navigationAuthStart));
  }
}
