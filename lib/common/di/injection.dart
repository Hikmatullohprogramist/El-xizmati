import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/di/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() => getIt.init();