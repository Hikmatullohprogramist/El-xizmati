import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../common/base/base_storage.dart';
import '../../domain/model/categories/category/category_response.dart';

@lazySingleton
class CategoriesStorage {
  CategoriesStorage(this._box);

  final Box _box;

  BaseStorage<CategoryRootResponse> get categoriesStorage => BaseStorage(_box);

  @FactoryMethod(preResolve: true)
  static Future<CategoriesStorage> create() async {
    Hive.registerAdapter(CategoryRootResponseAdapter());
    final box = await Hive.openBox<CategoryRootResponse>('categories_storage');
    return CategoriesStorage(box);
  }
}
