import 'package:El_xizmati/core/handler/future_handler.dart';

extension FutureExtensions<T> on Future<T> {
  FutureHandler<T> initFuture() => FutureHandler(this);
}
