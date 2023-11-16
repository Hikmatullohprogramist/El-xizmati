import 'package:hive/hive.dart';

class BaseStorage<T> {
  final Box box;

  final String? key;

  String get _key => key ?? T.runtimeType.toString();

  BaseStorage(this.box, {this.key});

  T? call() => box.get(_key);

  T callList() => box.get(_key, defaultValue: []);

  List<dynamic> allItems() => box.values.toList();

  Future<void> set(T? value) => box.put(_key, value);

  Future<void> delete() => box.delete(_key);

  Future<void> clear() => box.clear();

  Future<void> add(T value) => box.add(value);

  Future<void> addAll(List<T> values) => box.addAll(values);
}
