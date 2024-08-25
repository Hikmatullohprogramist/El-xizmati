import 'package:get_it/get_it.dart';
import 'package:El_xizmati/presentation/stream_controllers/app_theme_mode_stream_controller.dart';
import 'package:El_xizmati/presentation/stream_controllers/selected_region_stream_controller.dart';

extension GetItModuleApp on GetIt {
  Future<void> streamControllerModule() async {
    registerLazySingleton(() => AppThemeModeStreamController());
    registerLazySingleton(() => SelectedRegionStreamController());
    await allReady();
  }
}
