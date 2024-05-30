import 'package:onlinebozor/data/datasource/floor/entities/category_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/domain/models/category/category.dart';

extension CategoryResponseMapper on CategoryResponse {
  CategoryEntity toCategoryEntity() {
    return CategoryEntity(
      id: id,
      name: name ?? "",
      keyWord: key_word,
      parentId: parent_id,
      icon: icon,
      type: type,
      adCount: amount,
    );
  }

  Category toCategory() {
    return Category(
      id: id,
      name: name ?? "",
      keyWord: key_word,
      parentId: parent_id,
      icon: icon,
      type: type,
      adCount: amount,
    );
  }
}

extension CategoryEntityMapper on CategoryEntity {
  Category toCategory() {
    return Category(
      id: id,
      name: name,
      keyWord: keyWord,
      parentId: parentId,
      icon: icon,
      type: type,
    );
  }
}
