import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../common/base/base_storage.dart';

@lazySingleton
class CurrencyStorage {
  CurrencyStorage(this._box);

  final Box _box;
  final String currencyNameKey = "language_name_key";

  BaseStorage<String> get currencies =>
      BaseStorage(_box, key: currencyNameKey);

  @FactoryMethod(preResolve: true)
  static Future<CurrencyStorage> create() async {
    final box = await Hive.openBox('currency_storage');
    return CurrencyStorage(box);
  }
}
