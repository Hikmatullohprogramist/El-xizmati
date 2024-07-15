import 'package:get_it/get_it.dart';
import 'package:onlinebozor/presentation/stream_controllers/app_theme_mode_stream_controller.dart';

extension GetItModuleApp on GetIt {
  Future<void> streamControllerModule() async {
    registerLazySingleton(() => AppThemeModeStreamController());

    await allReady();
  }
}
