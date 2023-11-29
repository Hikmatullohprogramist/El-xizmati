import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/hive_object/ad/ad_hive_object.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/core/base_storage.dart';

@lazySingleton
class FavoriteStorage {
  FavoriteStorage(this._box);

  final Box _box;

  BaseStorage get favoriteAds => BaseStorage(
        _box,
        key: "key_favorites_storage",
      );

  @FactoryMethod(preResolve: true)
  static Future<FavoriteStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(3)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(AdHiveObjectAdapter());
    }
    final box = await Hive.openBox('favorites_storage');
    return FavoriteStorage(box);
  }

  List<AdHiveObject> get allItems => _box.values.toList().cast<AdHiveObject>();

  Future<void> removeFavorite(int adId) async {
    final allItem = _box.values.toList().cast<AdHiveObject>();
    final index = allItem.indexWhere((element) => element.id == adId);
    _box.deleteAt(index);
  }
}
