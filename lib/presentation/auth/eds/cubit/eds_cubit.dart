import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

part 'eds_cubit.freezed.dart';
part 'eds_state.dart';

@injectable
class EdsCubit extends BaseCubit<EdsBuildable, EdsListenable> {
  EdsCubit() : super(const EdsBuildable());

  void setFinishUrl(String url) {
    display.success(url);
    log.w("finish url $url");
  }

  void setStartUrl(String url) {
    display.success(url);
    log.w("start url $url");
  }

  void request(String url) {
    display.success(url);
    log.w("request url $url");
  }

  void setNavigation(String navigation) {
    display.success(navigation);
  }

  void error() {
    display.error("error xatlik yuz berdi");
  }

  Future<void> loginWithEds(String url) async {
    try {} on DioException {}
  }
}
