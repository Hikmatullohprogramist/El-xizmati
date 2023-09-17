import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'set_language_cubit.freezed.dart';
part 'set_language_state.dart';

@injectable
class SetLanguageCubit
    extends BaseCubit<SetLanguageBuildable, SetLanguageListenable> {
  SetLanguageCubit() : super(const SetLanguageBuildable());

 Future<void> setLanguage(Language language) async {

    invoke(SetLanguageListenable(
      SetLanguageEffect.navigationAuthStart,
    ));
    build((buildable) => buildable);
  }
}

enum Language { uz, ru }
