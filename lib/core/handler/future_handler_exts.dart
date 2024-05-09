import 'package:onlinebozor/core/handler/future_handler.dart';

extension FutureExtensions<T> on Future<T> {
  FutureHandler<T> initFuture() => FutureHandler(this);
}
