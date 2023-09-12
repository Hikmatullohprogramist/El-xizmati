import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_storage.dart';
import 'package:onlinebozor/domain/model/token/token.dart';

@lazySingleton
class Storage {
  Storage(this._box);

  final Box _box;

  BaseStorage<Token> get token => BaseStorage(_box);

  @FactoryMethod(preResolve: true)
  static Future<Storage> create() async {
    Hive.registerAdapter(TokenAdapter());
    final box = await Hive.openBox('storage');
    return Storage(box);
  }
}
