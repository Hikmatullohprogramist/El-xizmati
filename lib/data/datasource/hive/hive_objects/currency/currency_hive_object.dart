import 'package:hive/hive.dart';

part 'currency_hive_object.g.dart';

@HiveType(typeId: 1)
class CurrencyHiveObject {
  CurrencyHiveObject({
    required this.id,
    this.name,
  });

  @HiveField(1)
  int id;

  @HiveField(2)
  String? name;
}
