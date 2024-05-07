import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());

  void setFinishUrl(String url) {
    snackBarManager.success(url);
    logger.w("finish url $url");
  }

  void setStartUrl(String url) {
    snackBarManager.success(url);
    logger.w("start url $url");
  }

  void request(String url) {
    snackBarManager.success(url);
    logger.w("request url $url");
  }

  void setNavigation(String navigation) {
    snackBarManager.success(navigation);
  }

  void error() {
    snackBarManager.error("error xatlik yuz berdi");
  }

  Future<void> loginWithEds(String url) async {
    try {} catch (e) {
      logger.w(e);
    }
  }
}
