import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/core/base_storage.dart';
import '../hive_objects/ad/ad_object.dart';

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
        ..registerAdapter(AdObjectAdapter());
    }
    final box = await Hive.openBox('favorites_storage');
    return FavoriteStorage(box);
  }

  List<AdObject> get allItems => _box.values.toList().cast<AdObject>();

  Future<void> removeFavorite(int adId) async {
    final allItem = _box.values.toList().cast<AdObject>();
    final index = allItem.indexWhere((element) => element.id == adId);
    _box.deleteAt(index);
  }

  Future<void> update(int index, AdObject adObject) async {
    _box.putAt(index, adObject);
  }
}
