import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/core/box_value.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class CategoriesStorage {
  CategoriesStorage(this._box);

  static const String STORAGE_BOX_NAME = "categories_storage";
  final String KEY_PRODUCT_CATEGORIES = "string_product_categories";
  final String KEY_SERVICE_CATEGORIES = "string_service_categories";
  final String KEY_REQUEST_CATEGORIES = "string_request_categories";
  final String KEY_POPULAR_CATEGORIES = "string_request_categories";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<CategoriesStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(CategoryResponseImplAdapter());

    final box = await Hive.openBox<List>(STORAGE_BOX_NAME);
    return CategoriesStorage(box);
  }

  BoxValue<List> get _productCategoriesBox =>
      BoxValue(_box, key: KEY_PRODUCT_CATEGORIES);

  Future<void> clear() async {
    await _productCategoriesBox.clear();
  }
}
