import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/state_repository.dart';

part 'create_ad_chooser_cubit.freezed.dart';

part 'create_ad_chooser_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()){
    isLogin();

  }
  final StateRepository repository;

  Future<void> isLogin() async {
    final isLogin = await repository.isLogin() ?? false;
    updateState((state) => state.copyWith(isLogin: isLogin));
  }
