import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/base/base_storage.dart';
import '../../domain/model/categories/category/category_response.dart';

@lazySingleton
class CategoriesStorage {
  CategoriesStorage(this._box);

  final Box _box;

  BaseStorage<List> get categoriesStorage =>
      BaseStorage(_box, key: "key_categories_storage");

  @FactoryMethod(preResolve: true)
  static Future<CategoriesStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(CategoryResponseAdapter());
    final box =
        await Hive.openBox<List>('categories_storage');
    return CategoriesStorage(box);
  }
}
