import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/constants/hive_constants.dart';
import 'package:onlinebozor/data/datasource/hive/core/box_value.dart';
import 'package:path_provider/path_provider.dart';

import '../hive_objects/ad/ad_hive_object.dart';

@lazySingleton
class FavoriteStorage {
  FavoriteStorage(this._box);

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<FavoriteStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(HiveConstants.AD_TYPE_ID)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(AdHiveObjectAdapter());
    }
    final box = await Hive.openBox('favorites_storage');
    return FavoriteStorage(box);
  }

  BoxValue get favoriteAds => BoxValue(_box, key: "key_favorites_storage");

  List<AdHiveObject> get allItems => _box.values.toList().cast<AdHiveObject>();

  Future<void> removeFromFavorite(int adId) async {
    final allItem = _box.values.toList().cast<AdHiveObject>();
    final index = allItem.indexWhere((e) => e.id == adId);
    _box.deleteAt(index);
  }

  Future<void> update(int index, AdHiveObject adObject) async {
    _box.putAt(index, adObject);
  }
}
