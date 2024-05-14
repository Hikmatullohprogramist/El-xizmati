import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/constants/hive_constants.dart';
import 'package:onlinebozor/data/datasource/hive/core/box_value.dart';
import 'package:path_provider/path_provider.dart';

import '../hive_objects/ad/ad_hive_object.dart';

@lazySingleton
class AdStorage {
  AdStorage(this._box);

  static const String STORAGE_BOX_NAME = "ad_storage";
  static const String KEY_AD = "json_ad";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<AdStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(HiveConstants.AD_TYPE_ID)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(AdHiveObjectAdapter());
    }
    final box = await Hive.openBox('cart_storage');
    return AdStorage(box);
  }

  BoxValue<AdHiveObject> get _adBox => BoxValue(_box, key: KEY_AD);

  List<AdHiveObject> get allAds => _box.values.toList().cast<AdHiveObject>();

  List<AdHiveObject> get cartAds =>
      _adBox.values().filterIf((e) => e.isAddedToCart);

  List<AdHiveObject> get favoriteAds =>
      _adBox.values().filterIf((e) => e.isFavorite);

  int indexOf(int adId) => allAds.indexIf((e) => e.id == adId);

  AdHiveObject? adAt(int adId) => allAds.firstIf((e) => e.id == adId);

  ValueListenable<Box<dynamic>> listenable() => _box.listenable(keys: [KEY_AD]);

  Future<void> upsert(AdHiveObject ad) async {
    final index = indexOf(ad.id);
    if (index >= 0) {
      _adBox.update(index, ad);
    } else {
      _adBox.add(ad);
    }
  }

  Future<void> add(AdHiveObject ad) async {
    _adBox.add(ad);
  }

  Future<void> update(AdHiveObject ad) async {
    final index = indexOf(ad.id);
    _adBox.update(index, ad);
  }

  Future<void> addToCart(AdHiveObject ad) async {
    return upsert(ad..isAddedToCart = true);
  }

  Future<void> removeFromCart(int adId) async {
    final ad = allAds.firstIf((e) => e.id == adId);
    if (ad != null) {
      return upsert(ad..isAddedToCart = false);
    }
  }

  Future<void> addToFavorite(AdHiveObject ad) async {
    return upsert(ad..isFavorite = true);
  }

  Future<void> removeFromFavorite(int adId) async {
    final ad = allAds.firstIf((e) => e.id == adId);
    if (ad != null) {
      return upsert(ad..isFavorite = false);
    }
  }

  Future<void> clear() => _adBox.clear();
}
