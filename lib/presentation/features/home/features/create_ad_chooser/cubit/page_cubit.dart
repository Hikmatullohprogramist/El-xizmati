import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    isUserLoggedIn();
  }

  final StateRepository repository;

  Future<void> isUserLoggedIn() async {
    final isUserLoggedIn = repository.isUserLoggedIn();
    updateState((state) => state.copyWith(isLogin: isUserLoggedIn));
  }
}
