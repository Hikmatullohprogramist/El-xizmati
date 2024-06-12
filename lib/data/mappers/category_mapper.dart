import 'package:onlinebozor/data/datasource/floor/entities/category_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/domain/models/category/category_type.dart';

extension CategoryResponseMapper on CategoryResponse {
  CategoryEntity toCategoryEntity(CategoryType categoryType) {
    return CategoryEntity(
      id: id,
      name: name ?? "",
      keyWord: key_word,
      parentId: parent_id,
      icon: icon,
      type: categoryType.stringValue,
      adCount: amount,
    );
  }

  Category toCategory(CategoryType categoryType) {
    return Category(
      id: id,
      name: name ?? "",
      keyWord: key_word,
      parentId: parent_id,
      icon: icon,
      type: categoryType,
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
      parentId: parentId != null && parentId! > 0 ? parentId : null,
      icon: icon,
      type: type.toCategoryType(),
    );
  }
}
