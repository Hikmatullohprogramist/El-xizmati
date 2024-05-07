import 'package:hive/hive.dart';

class BoxValue<T> {
  final Box box;

  final String? key;

  String get _key => key ?? T.runtimeType.toString();

  BoxValue(this.box, {this.key});

  T? getOrNull() => box.get(_key);

  T getOrDefault(dynamic value) => box.get(_key, defaultValue: value);

  List<dynamic> values() => box.values.toList();

  Future<void> set(T? value) => box.put(_key, value);

  Future<void> delete() => box.delete(_key);

  Future<void> clear() => box.clear();

  Future<void> add(T value) => box.add(value);

  Future<void> addAll(List<T> values) => box.addAll(values);
}
