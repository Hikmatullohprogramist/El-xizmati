import 'package:hive/hive.dart';

class BaseStorage<T> {
  final Box box;

  final String? key;

  String get _key => key ?? T.runtimeType.toString();

  BaseStorage(this.box, {this.key});

  T? call() => box.get(_key);

  Future<void> set(T? value) => box.put(_key, value);

  Future<void> delete() => box.delete(_key);
}
