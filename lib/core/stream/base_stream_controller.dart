import 'dart:async';

class BaseStreamController<T> {
  final StreamController<T> _controller;

  BaseStreamController({
    bool sync = false,
    bool isBroadcast = false,
  }) : _controller = isBroadcast
            ? StreamController<T>.broadcast(sync: sync)
            : StreamController<T>(sync: sync);

  // Expose the stream
  Stream<T> get stream => _controller.stream;

  // Method to add data to the stream
  void add(T event) {
    _controller.add(event);
  }

  // Method to add data to the stream and close the stream
  Future<void> addAndClose(T event) async {
    _controller.add(event);
    await _controller.close();
  }

  // Method to handle errors
  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  // Method to close the stream
  Future<void> close() {
    return _controller.close();
  }

  // Method to check if the stream is closed
  bool get isClosed => _controller.isClosed;

  // Method to check if the stream has listeners
  bool get hasListener => _controller.hasListener;

  // Method to expose the sink
  StreamSink<T> get sink => _controller.sink;

  // Method to listen to the stream
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
